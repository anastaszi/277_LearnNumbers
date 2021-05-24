//
//  ScoreView.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/24/21.
//

import SwiftUI

struct ScoreView: View {
    @Binding var score: Int;
    
    var startColor = Color.yellow
    var endColor = Color.red
    
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .top, endPoint: .bottom))
            .frame(width: 100, height: 100)
            Text("\(score)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: .constant(5))
    }
}
