//
//  LearnButton.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import SwiftUI

struct LearnButton: View {
    @Binding var start: Bool;
    var body: some View {
        VStack(alignment: .center) {
            Button(action: {
                self.start = !self.start;
                }) {
                Text("Start")
            }.buttonStyle(GradientBackgroundStyle(startColor: Color.pink, endColor: Color.purple))
            

            }
    }
}

struct LearnButton_Previews: PreviewProvider {
    static var previews: some View {
        LearnButton(start: .constant(false))
    }
}
