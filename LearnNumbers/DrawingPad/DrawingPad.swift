//
//  DrawingPad.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import SwiftUI

struct DrawingPad: View {
    @Binding var currentDrawing: Drawing
    @Binding var drawings: [Drawing]
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for drawing in self.drawings {
                    self.add(drawing: drawing, toPath: &path)
                }
                self.add(drawing: self.currentDrawing, toPath: &path)
            }
            .stroke(Color.black, lineWidth: 5.0)
            .background(Color(white: 0.99))
            .gesture(
                    DragGesture(minimumDistance: 0.1)
                        .onChanged({ (value) in
                            let currentPoint = value.location
                            if currentPoint.y >= 0
                                && currentPoint.y < geometry.size.height {
                                self.currentDrawing.points.append(currentPoint)
                            }
                        })
                        .onEnded({ (value) in
                            self.drawings.append(self.currentDrawing)
                            self.currentDrawing = Drawing()
                        })
            )
        }
        .frame(maxHeight: .infinity)
    }
    
    private func add(drawing: Drawing, toPath path: inout Path) {
        let points = drawing.points
        if points.count > 1 {
            for i in 0..<points.count-1 {
                let current = points[i]
                let next = points[i+1]
                path.move(to: current)
                path.addLine(to: next)
            }
        }
    }
    
}



struct DrawingPad_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPad(currentDrawing: .constant(Drawing()), drawings: .constant([]))
    }
}
