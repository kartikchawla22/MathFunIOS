//
//  QuestionsModel.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-20.
//

import Foundation
class RandomQuestionsModel {
    private let gameModel = GameModel.shared
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
