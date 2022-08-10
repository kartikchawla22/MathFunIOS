//
//  HighScoreTableViewController.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-27.
//

import UIKit

/// This Controller is responsible for showing user scores.
class HighScoreTableViewController: UITableViewController {
    // MARK: - Class Variables
    
    /// shared instance of GameModel class, which is a singleton Class.
    let gameModel = GameModel.shared
    
    /// Array of privious game data
    var gameDataArr = [GameData]()
    
    
    // MARK: - Class View Overrides
    
    /// This function is called whenever this controller is in the view.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        tableView.reloadData()
        title = gameModel.getSelectedMode() + " Game"
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem( title: "Home", style: .plain, target: self, action: #selector(backButtonAction))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    
    // MARK: - Class Functions
    
    /// Function used by back button generated in viewWillAppear function.
    @objc func backButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /// Function used to load the privious game data from storage.
    func loadData(){
        let numberOfGames = UserDefaults.standard.integer(forKey: Constants.NUM_GAMES + gameModel.getSelectedMode())
        for i in (0..<numberOfGames) {
            let gameNumber = i + 1
            let score = UserDefaults.standard.integer(forKey: String(Constants.SCORE)  + gameModel.getSelectedMode() + String(gameNumber))
            let dateTime = UserDefaults.standard.string(forKey: String(Constants.DATE_TIME)  + gameModel.getSelectedMode() + String(gameNumber))
            let thisGameData = GameData(score: score, dateTime: dateTime!)
            gameDataArr.append(thisGameData)
        }
    }
    
    
    // MARK: - Table view data source
    
    /// Returns the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Returns the total number of games for a particular mode
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfGames = UserDefaults.standard.integer(forKey: Constants.NUM_GAMES + gameModel.getSelectedMode())
        return numberOfGames
    }
    
    
    /// Returns the call for a perticular row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath) as! HighScoreTableViewCell
        let thisRowData = gameDataArr[indexPath.row]
        cell.indexLabel.text = String(indexPath.row + 1)
        cell.score.text = String(thisRowData.score)
        cell.timeStamp.text = thisRowData.dateTime
        return cell
    }
}


// MARK: - Structs

/// Structure of data that is being saved in the game.
struct GameData {
    var score: Int
    var dateTime: String
}
