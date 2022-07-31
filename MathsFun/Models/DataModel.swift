//
//  DataModel.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-30.
//

import Foundation
class DataModel {
    func saveGame(score: Int, dateTime: String, mode: String) {
        print("score")
        print(score)
        print("mode")
        print(mode)
        let numOfGamesPlayed = UserDefaults.standard.integer(forKey: Constants.NUM_GAMES + mode)
        let currentGame = numOfGamesPlayed + 1;
        print(Constants.SCORE  + mode + String(currentGame))
        UserDefaults.standard.set(score, forKey: Constants.SCORE  + mode + String(currentGame))
        print(Constants.DATE_TIME  + mode + String(currentGame))
        print(dateTime)
        UserDefaults.standard.set(dateTime, forKey: Constants.DATE_TIME  + mode + String(currentGame))
        UserDefaults.standard.set(currentGame, forKey: Constants.NUM_GAMES + mode)
    }
    func saveCurrentGame(score: Int, time: Int, mode: String) {
        UserDefaults.standard.set(mode, forKey: Constants.CURRENT_GAME_MODE)
        UserDefaults.standard.set(score, forKey: Constants.CURRENT_GAME_SCORE)
        UserDefaults.standard.set(time, forKey: Constants.CURRENT_GAME_TIMER )
    }
    
}
struct Constants {
    static let NUM_GAMES = "NumberOfGamesPlayed"
    static let DATE_TIME = "DateTime"
    static let SCORE = "Score"
    static let CURRENT_GAME_TIMER = "CurrentGameTimer"
    static let CURRENT_GAME_SCORE = "CurrentGameScore"
    static let CURRENT_GAME_MODE = "CurrentGameMode"
    static let OPERATIONS = ["+", "-", "/", "*"]
}