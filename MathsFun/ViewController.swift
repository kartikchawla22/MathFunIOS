//
//  ViewController.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-20.
//

import UIKit

/// First controller of the application
class ViewController: UIViewController {
    // MARK: - IBOutlets
    
    /// Continue button shown on the UI
    @IBOutlet weak var continueButton: UIButton!
    
    
    //MARK: - Class variables
    /// shared instance of GameModel class, which is a singleton Class.
    let gameModel = GameModel.shared
    /// Object of DataModel Class
    let dataModel = DataModel()
    /// instance of the storyBoard
    var storyBoard : UIStoryboard!
    
    
    // MARK: - Class Overrides
    
    // Used to initiliaze variables
    override func viewDidLoad() {
        super.viewDidLoad()
        storyBoard = UIStoryboard(name: "Main", bundle:nil)
    }
    
    // Called everytime this controller is about to appear
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
    
    /// This function sets the user selected game mode and starts the game accordingly.
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
    
    /// This function is used to go to the game board, depending upon what mode user selects.
    func goToGameBoard() {
        if(gameModel.getSelectedMode() == Game_Modes.HARD) {
            let hardGameBoardViewController = storyBoard.instantiateViewController(withIdentifier: "HardGameBoard") as! HardModeGameBoardViewController
            navigationController?.pushViewController(hardGameBoardViewController, animated: true)
            
        } else {
            let gameBoardViewController = storyBoard.instantiateViewController(withIdentifier: "GameBoard") as! GameBoardViewController
            navigationController?.pushViewController(gameBoardViewController, animated: true)
        }
    }
    
    
    /// This function is used to show the alert using which player can choose the game mode.
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
    
    /// Called when played clicks on new game button
    @IBAction func onNewGameTouch(_ sender: UIButton) {
        showAlert(segue: "GameBoard")
    }
    
    /// Called when played clicks on show score button
    @IBAction func viewHighScore(_ sender: UIButton) {
        showAlert(segue: "HighScoreList")
    }
    
    /// Called when player clicks on contunue game button
    @IBAction func onContinueGameTouch(_ sender: Any) {
        goToGameBoard()
    }
}

