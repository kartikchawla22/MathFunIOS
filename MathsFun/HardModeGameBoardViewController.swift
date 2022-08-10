//
//  HardModeGameBoardViewController.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-08-01.
//

import UIKit

/// This controller handles the game operations in hard mode
class HardModeGameBoardViewController: UIViewController {
    
    // MARK: - IOBOutlets
    
    /// Label in which player selected game mode will appear
    @IBOutlet weak var modeLabel: UILabel!
    
    /// Label in which countdown timer will appear.
    @IBOutlet weak var timerLabel: UILabel!
    
    /// Label in which new question will appear.
    @IBOutlet weak var questionLabel: UILabel!
    
    /// Fields where player will enter the answer.
    @IBOutlet weak var answerTextField: UITextField!
    
    
    // MARK: - Class Variables
    
    /// Timer after which game will end automatically.
    var timer = Timer()
    
    /// Counter in seconds => 300 seconds means 5 minutes
    var counter = 300
    
    /// Shared instance of GameModel class, which is a singleton Class.
    let gameModel = GameModel.shared
    
    /// Main Story board of the application
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    /// Object of class DataModel
    let dataModel = DataModel()
    
    ///The score of the player, -1 so that initial score can be calculated as 0.
    var totalScore = -1;
    
    
    // MARK: - Class Overrides
    
    /// This function is called whenever this controller is in the view.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (dataModel.isGameSaved()) {
            totalScore = UserDefaults.standard.integer(forKey: Constants.CURRENT_GAME_SCORE)
            counter = UserDefaults.standard.integer(forKey: Constants.CURRENT_GAME_TIMER)
            gameModel.setSelectedMode(mode: UserDefaults.standard.string(forKey: Constants.CURRENT_GAME_MODE)!)
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in self.timerAction() }
        showNewQuestion()
        modeLabel.text = gameModel.getSelectedMode() + "-Game"
    }
    
    /// This function is called when this controller disappears from the view
    /// We invalidated the timer here.
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    
    // MARK: - Class functions
    
    /// This function is used to show the next question
    func showNewQuestion() {
        totalScore+=1
        answerTextField.text = ""
        let newQuestion = gameModel.generateRandomQuestion()
        questionLabel.text = newQuestion
    }
    
    /// This function is called for every next tick of the timer.
    func timerAction() {
        let minutes = Int(counter / 60)
        let seconds = counter % 60
        counter = counter - 1
        if seconds < 10 {
            timerLabel.text = "\(minutes) : 0\(seconds) "
        } else {
            timerLabel.text = "\(minutes) : \(seconds) "
        }
        if counter == 0 {
            timerLabel.text = "0 : 00 "
            timer.invalidate()
            endGame()
            showFinishGameAlert(message: "Congratulations")
        }
        dataModel.saveCurrentGame(score: totalScore, time: counter, mode: gameModel.getSelectedMode())
    }
    
    /// Once the game is finished this function is used to show the message.
    func showFinishGameAlert(message: String) {
        let alert = UIAlertController(title: "Game Finished", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.goToScoreList()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// This function is used to go to the score list.
    func goToScoreList(){
        let highScoreList = storyBoard.instantiateViewController(withIdentifier: "HighScoreList") as! HighScoreTableViewController
        navigationController?.pushViewController(highScoreList, animated: true)
    }
    
    /// This function is called once the game ends
    func endGame(){
        dataModel.deleteCurrentGameState()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dateStr = formatter.string(from: Date())
        dataModel.saveGame(score: totalScore, dateTime: dateStr, mode: gameModel.getSelectedMode())
    }
    
    
    // MARK: - IBActions
    
    /// This function is called whenever player submits the answer
    @IBAction func checkAnswer(_ sender: UIButton) {
        if(answerTextField.text == "") {
            return
        }
        if answerTextField.text == String(gameModel.getResult()) {
            showNewQuestion()
        } else {
            endGame()
            timer.invalidate()
            showFinishGameAlert(message: "OOPS, Wrong Answer!")
        }
    }
}
