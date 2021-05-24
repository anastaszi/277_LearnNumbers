//
//  UserData.swift
//  LearnNumbers
//
//  Created by Anastasia Zimina on 5/23/21.
//

import Foundation

class UserData: ObservableObject {
    @Published var tests: [TestModel] = [];
    
    func newTest() -> TestModel {
        return TestModel();
    }
}
