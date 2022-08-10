//
//  DataModel.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-30.
//

import Foundation

/// Model to manage all the functionalities we need to managing the saved data.
class DataModel {
    
    /// This method saves the game score after each game is comepleted.
    func saveGame(score: Int, dateTime: String, mode: String) {
        let numOfGamesPlayed = UserDefaults.standard.integer(forKey: Constants.NUM_GAMES + mode)
        let currentGame = numOfGamesPlayed + 1;
        UserDefaults.standard.set(score, forKey: Constants.SCORE  + mode + String(currentGame))
        UserDefaults.standard.set(dateTime, forKey: Constants.DATE_TIME  + mode + String(currentGame))
        UserDefaults.standard.set(currentGame, forKey: Constants.NUM_GAMES + mode)
    }
    
    /// This method is used to save the current state of game.
    /// Used to pause the game at any time
    func saveCurrentGame(score: Int, time: Int, mode: String) {
        UserDefaults.standard.set(mode, forKey: Constants.CURRENT_GAME_MODE)
        UserDefaults.standard.set(score, forKey: Constants.CURRENT_GAME_SCORE)
        UserDefaults.standard.set(time, forKey: Constants.CURRENT_GAME_TIMER )
    }
    
    /// This Method is used to determine if there is a saved game in storage or not.
    /// returns a boolean
    func isGameSaved() -> Bool {
        let score = UserDefaults.standard.integer(forKey: Constants.CURRENT_GAME_SCORE)
        let time = UserDefaults.standard.integer(forKey: Constants.CURRENT_GAME_TIMER)
        let mode = UserDefaults.standard.string(forKey: Constants.CURRENT_GAME_MODE)
        return score > -1 && time > 0 && mode != ""
    }
    
    /// deletes the current game state, so that user can start a new game.
    func deleteCurrentGameState() {
        UserDefaults.standard.removeObject(forKey: Constants.CURRENT_GAME_MODE)
        UserDefaults.standard.removeObject(forKey: Constants.CURRENT_GAME_TIMER)
        UserDefaults.standard.removeObject(forKey: Constants.CURRENT_GAME_SCORE)
    }
}

/// Constants struct used throughout the code so that we can avoid mismatch errors.
struct Constants {
    static let NUM_GAMES = "NumberOfGamesPlayed"
    static let DATE_TIME = "DateTime"
    static let SCORE = "Score"
    static let CURRENT_GAME_TIMER = "CurrentGameTimer"
    static let CURRENT_GAME_SCORE = "CurrentGameScore"
    static let CURRENT_GAME_MODE = "CurrentGameMode"
    static let OPERATIONS = ["+", "-", "/", "*"]
}
