//
//  ViewController.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-20.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Class variables
    
    let gameModel = GameModel.shared;
    
    
    // MARK: Class Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setGameMode(mode: String, segue: String) {
        gameModel.setSelectedMode(mode: mode)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if(segue == "GameBoard") {
            let gameBoardViewController = storyBoard.instantiateViewController(withIdentifier: "GameBoard") as! GameBoardViewController
            gameBoardViewController.modalPresentationStyle = .fullScreen
            self.present(gameBoardViewController, animated:true, completion:nil)
        } else {
            let highScoreList = storyBoard.instantiateViewController(withIdentifier: "HighScoreList") as! HighScoreTableViewController
            self.present(highScoreList, animated:true, completion:nil)
        }
    
    }

    //MARK: - IBActions
    
    
    @IBAction func onNewGameTouch(_ sender: UIButton) {
        showAlert(segue: "GameBoard")
    }
    @IBAction func viewHighScore(_ sender: UIButton) {
        showAlert(segue: "HighScoreList")
    }
    
    // MARK: - Class Functions
    func showAlert(segue: String) {
        let alert = UIAlertController(title: "Game Mode", message: "Please Choose Game Mode", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Game_Modes.EASY, style: .default, handler: { (UIAlertAction) in
            self.setGameMode(mode: Game_Modes.EASY,segue: segue)
        }))
        alert.addAction(UIAlertAction(title: Game_Modes.MEDIUM, style: .default, handler: { (UIAlertAction) in
            self.setGameMode(mode: Game_Modes.MEDIUM,segue: segue)
        }))
        alert.addAction(UIAlertAction(title: Game_Modes.HARD, style: .default, handler: { (UIAlertAction) in
            self.setGameMode(mode: Game_Modes.HARD,segue: segue)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            return
        }))
        self.present(alert, animated: true)
    }
}

