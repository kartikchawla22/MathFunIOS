//
//  GameModel.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-20.
//

import Foundation

/// This class is a singleton class.
/// This Class is used to managed all the game functionalities like generating a random equation.
class GameModel {
    /// Shared instance of class GameModel
    static let shared = GameModel()
    /// Random number as first operand
    var firstNum = 0
    /// Random number as second operand
    var secondNum = 0
    /// Random operator
    var randomOperator = ""
    /// Generated question using random operands and operator
    var question = ""
    /// User Selected Mode
    private var selectedMode = ""
    /// Upper limit of the randomly generated numbers
    private var upperLimit = 11
    /// Lower limit of the randomly generated numbers
    private var lowerLimit = 1
    
    /// Sets the user selected mode in memory
    func setSelectedMode(mode: String) {
        selectedMode = mode
    }
    /// Fetches the user selected mode
    /// Returns the user selected mode as a String
    func getSelectedMode() -> String {
        return selectedMode
    }
    /// Generates Random Questions
    /// Returns the randomly generated question as a String
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
    
    
    /// Returns the result of a randomly generated question as an integer.
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
    /// Resets the game model variables to initial values
    func reset() {
        firstNum = 0
        secondNum = 0
        randomOperator = ""
        question = ""
        setSelectedMode(mode: "")
    }
}
/// Enum to get games modes so that we can avoid string mismatch errors.
enum Game_Modes {
    static let EASY = "Easy"
    static let MEDIUM = "Medium"
    static let HARD = "Hard"
}
