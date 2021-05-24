//
//  ContentView.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import SwiftUI

struct ContentView: View {
    @State var start = false;
    var body: some View {
        if (start) {
            DrawingTool()
        } else {
            LearnButton(start: $start)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
