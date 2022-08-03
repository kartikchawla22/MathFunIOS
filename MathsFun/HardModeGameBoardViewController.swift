//
//  HardModeGameBoardViewController.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-08-01.
//

import UIKit

class HardModeGameBoardViewController: UIViewController {
    
    // MARK: - IOBOutlets
    
    @IBOutlet weak var modeLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    
    // MARK: - Class Variables
    
    var timer = Timer()
    var counter = 300
    let gameModel = GameModel.shared
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let dataModel = DataModel()
    var totalScore = -1;
    
    
    // MARK: - Class Overrides
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    
    // MARK: - Class functions
    
    func showNewQuestion() {
        totalScore+=1
        answerTextField.text = ""
        let newQuestion = gameModel.generateRandomQuestion()
        questionLabel.text = newQuestion
    }
    
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
    
    func showFinishGameAlert(message: String) {
        let alert = UIAlertController(title: "Game Finished", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.goToScoreList()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func goToScoreList(){
        self.navigationController?.popViewController(animated: true)
        let highScoreList = storyBoard.instantiateViewController(withIdentifier: "HighScoreList") as! HighScoreTableViewController
        navigationController?.pushViewController(highScoreList, animated: true)
        
    }
    
    func endGame(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dateStr = formatter.string(from: Date())
        dataModel.saveGame(score: totalScore, dateTime: dateStr, mode: gameModel.getSelectedMode())
    }
    
    
    // MARK: - IBActions
    
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
