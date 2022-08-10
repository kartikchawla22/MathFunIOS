//
//  QuestionsModel.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-20.
//

import Foundation

/// This class generates random options that will be displayed in easy and medium mode.
class RandomQuestionsModel {
    
    /// hared instance of singleton class GameModel.
    private let gameModel = GameModel.shared
    
    /// Private method used to calculate the result of an equation using operator and operands.
    private func getResult(operation: String) -> Int {
        switch (operation) {
            case "+": return gameModel.firstNum + gameModel.secondNum;
            case "-": return gameModel.firstNum - gameModel.secondNum;
            case "*": return gameModel.firstNum * gameModel.secondNum;
            case "/": return gameModel.firstNum / gameModel.secondNum;
            case "%": return gameModel.firstNum % gameModel.secondNum;
            default: return gameModel.secondNum;
        }
    }
    
    /// This method generated random options for a particular equation.
    /// return an array of integer type data which consists of randomly generated options.
    public  func generateRandomOptions() -> [Int] {
        var randomResults =  [Int]()
        let operations = Constants.OPERATIONS.filter{$0 != gameModel.randomOperator}
        operations.forEach { operationElement in
            if(randomResults.contains(getResult(operation: operationElement))) {
                randomResults.append((getResult(operation: "%")))
            } else {
                randomResults.append(getResult(operation: operationElement))
            }
        }
        return randomResults;
    }
}
