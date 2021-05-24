//
//  SoundButton.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/24/21.
//

import SwiftUI

struct SoundButton: View {
    let playSound: () -> Void;
    var body: some View {
        VStack(alignment: .center) {
            Button(action:{playSound()},
                   label: {HStack {
                    Image(systemName:  "speaker.2" )
                        .foregroundColor(Color.white)}})
                .buttonStyle(GradientBackgroundStyle(startColor: Color.blue, endColor: Color.green))
                .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            }
    }
}

struct SoundButton_Previews: PreviewProvider {
    static var previews: some View {
        SoundButton(playSound: {})
    }
}
