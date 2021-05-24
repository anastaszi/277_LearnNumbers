//
//  DrawingTool.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import SwiftUI
import AVFoundation

struct DrawingTool: View {
    @StateObject var coreMLClassification = CoreMLClassification.shared
    @State private var currentDrawing: Drawing = Drawing()
    @State var step = 0;
    @State var task = 0;
    
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .center, spacing: 26.0){
                SoundButton(playSound: {outloudTask()})
                ScoreView(score: $coreMLClassification.score)
                NextButton(nextAction: {createTask()})
            
            }
            
            DrawingPad(currentDrawing: $currentDrawing,
                       drawings: $coreMLClassification.drawings)
                .onAppear{
                    self.createTask()
                    coreMLClassification.score = 0;
                }
            HStack{
                StartOverButton(drawings: $coreMLClassification.drawings)
            }
            }
    }
    
    func outloudTask() {
        let utterance = AVSpeechUtterance(string: "Can you draw me number \(self.task)?");
        //utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
   func createTask() {
        self.task = Int.random(in: 0...9);
        coreMLClassification.correctAnswer = self.task;
        coreMLClassification.drawings = [Drawing]();
    self.outloudTask();
    }

}

struct DrawingTool_Previews: PreviewProvider {
    static var previews: some View {
        DrawingTool()
    }
}
