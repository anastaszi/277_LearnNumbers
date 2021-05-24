//
//  TestModel.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import Foundation

class TestModel: Identifiable, Codable {
    var questions = [Int]();
    var answers = [Bool]();
    var totalScore: Int = 0;
    
    init() {
        for _ in 0...9 {
            self.questions.append(Int.random(in: 0...9))
        }
    }
    
    func addResult(result: Bool) {
        self.answers.append(result);
        totalScore += (result) ? 1 : 0;
    }
    
    func getScore() -> Int {
        return self.totalScore;
    }
    
}
