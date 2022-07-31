//
//  GameBoardViewController.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-20.
//

import UIKit

class GameBoardViewController: UIViewController {
    // MARK: - Class Variables
    
    var timer = Timer()
    var counter = 10
    let gameModel = GameModel.shared
    let randomQuestionsModel = RandomQuestionsModel()
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let dataModel = DataModel()
    var totalScore = -1;
    
    // MARK: - IBOutlets
    
    @IBOutlet var question: UILabel!
    
    @IBOutlet var timerLabel: UILabel!
    
    @IBOutlet var gameMode: UILabel!
    
    @IBOutlet var optionsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in self.timerAction() }
        showNewQuestion()
        gameMode.text = gameModel.getSelectedMode() + "-Game"
    }
    
    // MARK: - Class Functions
    
    func showNewQuestion() {
        totalScore+=1
        let newQuestion = gameModel.generateRandomQuestion()
        question.text = newQuestion
        setRandomOptions()
    }
    
    private func setRandomOptions() {
        var randomOptions: [Int] = randomQuestionsModel.generateRandomOptions()
        randomOptions.append(gameModel.getResult())
        for _ in (0..<randomOptions.count) {
            let firstIndex = Int.random(in: 0..<4)
            let secondIndex = Int.random(in: 0..<4)
            let temp = randomOptions[firstIndex]
            randomOptions[firstIndex] = randomOptions[secondIndex]
            randomOptions[secondIndex] = temp
        }
        
        for i in 0..<randomOptions.count {
            (optionsStackView.viewWithTag(i + 1) as! UIButton).setTitle(String(randomOptions[i]), for: .normal)
        }
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
    }
    
    
    // MARK: - IBActions
    
    @IBAction func buttonAction(_ sender: UIButton!) {
        if sender.currentTitle == String(gameModel.getResult()) {
            showNewQuestion()
        } else {
            endGame()
            timer.invalidate()
            showFinishGameAlert(message: "OOPS, Wrong Answer!")
        }
    }
    
    func showFinishGameAlert(message: String) {
        let alert = UIAlertController(title: "Game Finished", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.goToScoreList()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func goToScoreList(){
        let highScoreList = storyBoard.instantiateViewController(withIdentifier: "HighScoreList")
        self.present(highScoreList, animated:true, completion:nil)
    }
    func endGame(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let dateStr = formatter.string(from: Date())
        dataModel.saveGame(score: totalScore, dateTime: dateStr, mode: gameModel.getSelectedMode())
    }
}
