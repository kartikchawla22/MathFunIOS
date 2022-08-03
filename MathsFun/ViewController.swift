//
//  ViewController.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-20.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    //MARK: - Class variables
    
    let gameModel = GameModel.shared
    let dataModel = DataModel()
    var storyBoard : UIStoryboard!
    
    
    // MARK: - Class Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyBoard = UIStoryboard(name: "Main", bundle:nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameModel.reset()
        let isGameSaved = dataModel.isGameSaved()
        print(isGameSaved)
        if(isGameSaved) {
            print(UserDefaults.standard.string(forKey: Constants.CURRENT_GAME_MODE)!)
            gameModel.setSelectedMode(mode: UserDefaults.standard.string(forKey: Constants.CURRENT_GAME_MODE)!)
        }
        continueButton.isHidden = !isGameSaved
    }
    
    
    // MARK: - Class Functions
    
    func setGameModeAndStartGame(mode: String, segue: String) {
        gameModel.setSelectedMode(mode: mode)
        if(segue == "GameBoard") {
            dataModel.deleteCurrentGameState()
            goToGameBoard()
        } else {
            let highScoreList = storyBoard.instantiateViewController(withIdentifier: "HighScoreList") as! HighScoreTableViewController
            navigationController?.pushViewController(highScoreList, animated: true)
        }
    }
    
    func goToGameBoard() {
        if(gameModel.getSelectedMode() == Game_Modes.HARD) {
            let hardGameBoardViewController = storyBoard.instantiateViewController(withIdentifier: "HardGameBoard") as! HardModeGameBoardViewController
            navigationController?.pushViewController(hardGameBoardViewController, animated: true)
            
        } else {
            let gameBoardViewController = storyBoard.instantiateViewController(withIdentifier: "GameBoard") as! GameBoardViewController
            navigationController?.pushViewController(gameBoardViewController, animated: true)
        }
    }
    
    func showAlert(segue: String) {
        let alert = UIAlertController(title: "Game Mode", message: "Please Choose Game Mode", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Game_Modes.EASY, style: .default, handler: { (UIAlertAction) in
            self.setGameModeAndStartGame(mode: Game_Modes.EASY,segue: segue)
        }))
        alert.addAction(UIAlertAction(title: Game_Modes.MEDIUM, style: .default, handler: { (UIAlertAction) in
            self.setGameModeAndStartGame(mode: Game_Modes.MEDIUM,segue: segue)
        }))
        alert.addAction(UIAlertAction(title: Game_Modes.HARD, style: .default, handler: { (UIAlertAction) in
            self.setGameModeAndStartGame(mode: Game_Modes.HARD,segue: segue)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            return
        }))
        self.present(alert, animated: true)
    }
    
    
    //MARK: - IBActions
    
    @IBAction func onNewGameTouch(_ sender: UIButton) {
        showAlert(segue: "GameBoard")
    }
    
    @IBAction func viewHighScore(_ sender: UIButton) {
        showAlert(segue: "HighScoreList")
    }
    
    @IBAction func onContinueGameTouch(_ sender: Any) {
        goToGameBoard()
    }
}

