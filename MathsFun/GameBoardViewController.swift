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
    var counter = 70
    let gameModel = GameModel.shared
    let randomQuestionsModel = RandomQuestionsModel()
    
    // MARK: - IBOutlets
    
    @IBOutlet var question: UILabel!
    
    @IBOutlet var timerLabel: UILabel!
    
    @IBOutlet var gameMode: UILabel!
    
    @IBOutlet var optionsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in self.timerAction() }
        showNewQuestion()
    }
    
    // MARK: - Class Functions
    
    func showNewQuestion() {
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
            timer.invalidate()
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func buttonAction(_ sender: UIButton!) {
        if sender.currentTitle == String(gameModel.getResult()) {
            showNewQuestion()
        } else {
            print("Wrong")
        }
    }
    
   

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
