//
//  StartOverButton.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import SwiftUI

struct StartOverButton: View {
    @Binding var drawings: [Drawing]
    @State var clicked = false;
    var body: some View {
        VStack(alignment: .center) {
            Button(action: {
                self.clicked.toggle()
                self.drawings = [Drawing]()
                }) {
                HStack {
                    Image(systemName:  "bin.xmark" )
                     .foregroundColor(Color.yellow)
                    .rotationEffect(Angle.degrees(clicked ? 360 : 0))
                                        .animation(.spring())
                                }
            }.buttonStyle(GradientBackgroundStyle(startColor: Color.pink, endColor: Color.purple))
            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            

            }
    }
}

struct StartOverButton_Previews: PreviewProvider {
    static var previews: some View {
        StartOverButton(drawings: .constant([]))
    }
}
