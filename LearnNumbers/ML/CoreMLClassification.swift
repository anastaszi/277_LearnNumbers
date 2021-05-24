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
import Combine
import AVFoundation

class CoreMLClassification: ObservableObject {
    static let shared = CoreMLClassification()
    @Published var text: String?
    @Published var drawings: [Drawing] = [Drawing]()
    @Published var correctAnswer: Int = -1;
    @Published var score: Int = 0;
    
    private var bag = Set<AnyCancellable>()
    init (scheduler: DispatchQueue = DispatchQueue(label: "NumberDetection")) {
        $drawings
            .dropFirst(1)
            .debounce(for: .seconds(1), scheduler: scheduler) //debounce works by waiting a second until the user stops drawing
            .removeDuplicates()
            .filter{ $0.count >= 1 }
            .sink(receiveValue: updateClassifications(drawings:)) //You observe these events via sink(receiveValue:) and handle them with requestCurrentWeather(querycity:)
            .store(in: &bag)
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
    
    func updateClassifications(drawings: [Drawing]) {
        let image = getImage();
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
                let topClassification = classifications.prefix(1)
                let description = topClassification[0].identifier
                let check = Int(description) == self.correctAnswer
                if (check) {
                    self.score += 1;
                    self.outloudResult(result: "Good job!")
                } else {
                    self.outloudResult(result: "Not quite! Try again")
                }
                self.text = "Classification: \n" + description + "\(String(self.correctAnswer)) And result is \(check)"
            }
        }
    }

    func getImage () -> UIImage {
         let renderer = UIGraphicsImageRenderer(size: CGSize(width: 400, height: 500))
         let img = renderer.image { (context) in
             context.fill(CGRect(origin: .zero, size: CGSize(width: 400, height: 500)))
             context.cgContext.setLineWidth(20.0)
             context.cgContext.setStrokeColor(UIColor.white.cgColor)
            for drawing in self.drawings {
                 let points = drawing.points
                 if points.count > 1 {
                     for i in 0..<points.count-1 {
                         let current = points[i]
                         let next = points[i+1]
                         context.cgContext.move(to: current)
                         context.cgContext.addLine(to: next)
                     }
                 }
                 
             }
             context.cgContext.drawPath(using: .stroke)
         
         }
         return img
     }
    
    func outloudResult(result: String) {
        let utterance = AVSpeechUtterance(string: "\(result)");
        //utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
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
