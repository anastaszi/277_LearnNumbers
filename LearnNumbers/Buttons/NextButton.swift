//
//  NextButton.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/24/21.
//

import SwiftUI

struct NextButton: View {
    let nextAction: () -> Void;
    var color = Color.init(red: 38/255, green: 135/255, blue: 0/255);
    var body: some View {
        VStack(alignment: .center) {
            Button(action:{nextAction()},
                   label: {HStack {
                    //Text("Next")
                    //    .fontWeight(.bold)
                    //    .foregroundColor(self.color)
                    Image(systemName:  "arrow.right" )
                        .foregroundColor(self.color)}})
                .buttonStyle(GradientBackgroundStyle(startColor: Color.green, endColor: Color.yellow))
                .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            }
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(nextAction: {})
    }
}
