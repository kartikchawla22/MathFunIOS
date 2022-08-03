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
    private var upperLimit = 11
    private var lowerLimit = 1
    
    func setSelectedMode(mode: String) {
        selectedMode = mode
    }
    func getSelectedMode() -> String {
        return selectedMode
    }
    func generateRandomQuestion() -> String {
        randomOperator = Constants.OPERATIONS[Int.random(in: 0..<4)]
        if(selectedMode == Game_Modes.HARD) {
            upperLimit = 101
            lowerLimit = 50
        } else if(selectedMode == Game_Modes.MEDIUM){
            upperLimit = 51
            lowerLimit = 10
        } else {
            upperLimit = 11
            lowerLimit = 1
        }
        firstNum = Int.random(in: lowerLimit..<upperLimit)
        secondNum = Int.random(in: lowerLimit..<upperLimit)
        if (firstNum == secondNum) {
            secondNum = Int.random(in: lowerLimit..<upperLimit)
        }
        if (randomOperator == "/") {
            if(selectedMode == Game_Modes.HARD) {
                firstNum = Int.random(in: 1..<21) * secondNum
            } else if(selectedMode == Game_Modes.MEDIUM) {
                firstNum = Int.random(in: 1..<12) * secondNum
            } else {
                firstNum = Int.random(in: 1..<5) * secondNum
            }
            
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
    func reset() {
        firstNum = 0
        secondNum = 0
         randomOperator = ""
         question = ""
        setSelectedMode(mode: "")
    }
}

enum Game_Modes {
    static let EASY = "Easy"
    static let MEDIUM = "Medium"
    static let HARD = "Hard"
}
