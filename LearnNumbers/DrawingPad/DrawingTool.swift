//
//  DrawingTool.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import SwiftUI

struct DrawingTool: View {
    @StateObject var coreMLClassification = CoreMLClassification.shared
    @State private var currentDrawing: Drawing = Drawing()
    @State private var drawings: [Drawing] = [Drawing]()
    
    var body: some View {
        VStack(alignment: .center) {
            HStack{
                Text("Draw something")
                    .font(.largeTitle)
                StartOverButton(drawings: $drawings)
            }
            DrawingPad(currentDrawing: $currentDrawing,
                       drawings: $drawings)
            Button("Save to image") {
                let image = self.getImage()
                coreMLClassification.updateClassifications(for: image)
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
            Text("Classification results: \(coreMLClassification.text ?? "")").padding()
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
    
    

}

struct DrawingTool_Previews: PreviewProvider {
    static var previews: some View {
        DrawingTool()
    }
}
