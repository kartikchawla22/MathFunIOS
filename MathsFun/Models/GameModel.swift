//
//  GameModel.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-20.
//

import Foundation
class GameModel {
    
    static let shared = GameModel()
    
    var firstNum = 0
    var secondNum = 0
    var randomOperator = ""
    var question = ""
    private var selectedMode = ""

    func setSelectedMode(mode: String) {
        selectedMode = mode
    }
    func getSelectedMode() -> String {
        return selectedMode
    }
    func generateRandomQuestion() -> String {
        randomOperator = Constants.OPERATIONS[Int.random(in: 0..<4)]
        firstNum = Int.random(in: 0..<11)
        secondNum = Int.random(in: 1..<11)
        if (firstNum == secondNum) {
            secondNum = Int.random(in: 0..<11)
        }
        if (randomOperator == "/") {
            firstNum = Int.random(in: 1..<5) * secondNum
        }
        question = "\(firstNum) \(randomOperator) \(secondNum) = ?"
        return question
    }

    func getResult() -> Int {
        switch randomOperator {
            case "+":
                return firstNum + secondNum
            case "-":
                return firstNum - secondNum
            case "/":
                return Int(firstNum / secondNum)
            case "*":
                return firstNum * secondNum
            default:
                return secondNum
        }
    }
}

enum Constants {
    static let OPERATIONS = ["+", "-", "/", "*"]
}

enum Game_Modes {
    static let EASY = "Easy"
    static let MEDIUM = "Medium"
    static let HARD = "Hard"
}
