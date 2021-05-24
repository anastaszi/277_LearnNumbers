//
//  CoreMLClassification.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import Foundation
import SwiftUI
import CoreML
import Vision
import ImageIO

class CoreMLClassification: ObservableObject {
    static let shared = CoreMLClassification()
    @Published var text: String?
    
    init () {
        
    }
    
    lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let config = MLModelConfiguration()
            let model = try VNCoreMLModel(for: MNISTClassifier(configuration: config).model)
            let request = VNCoreMLRequest(model: model, completionHandler: {[weak self] request, error in
                self?.processClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request;
        } catch {
            fatalError("Failed to load model")
        }
    }()
    
    func updateClassifications(for image: UIImage) {
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else {fatalError("Unable to cerade")}
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {try handler.perform([self.classificationRequest])}
            catch {
                print ("Hailed to perform classification")
            }
        }
    }
    
    func processClassifications(for request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            guard let results = request.results else {
                self.text = "Unable to classifi image.\n\(error!.localizedDescription)"
                return
            }
            
            let classifications = results as! [VNClassificationObservation]
            
            if classifications.isEmpty {
                self.text = "Nothing recognized"
            } else {
                let topClassifications = classifications.prefix(1)
                let descriptions = topClassifications.map { classification in
                    return String(format: " (%.2f) %@", classification.confidence, classification.identifier)
                }
                self.text = "Classification: \n" + descriptions.joined(separator: "\n")
            }
        }
    }
}

extension CGImagePropertyOrientation {
    init(_ orientation: UIImage.Orientation) {
        switch orientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}
