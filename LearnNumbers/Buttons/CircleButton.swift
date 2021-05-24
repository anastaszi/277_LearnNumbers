//
//  CircleParams.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import Foundation
import CoreGraphics
import SwiftUI

struct CircleButton: View {
    var body: some View {
        let color1 = Color(red: 225.0 / 255, green: 224.0 / 255, blue:28.0 / 255)
        let color2 = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
        let spectrum = Gradient(colors: [ color1, color2])
        let conic =
            LinearGradient(gradient: spectrum, startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 0.6))
        return Circle().fill(conic, style: FillStyle.init())
    }
}
