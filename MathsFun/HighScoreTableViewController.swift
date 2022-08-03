//
//  HighScoreTableViewController.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-27.
//

import UIKit

class HighScoreTableViewController: UITableViewController {
    // MARK: - Class Variables
    
    let gameModel = GameModel.shared
    var gameDataArr = [GameData]()
    
    
    // MARK: - Class View Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
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
    
    @objc func backButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfGames = UserDefaults.standard.integer(forKey: Constants.NUM_GAMES + gameModel.getSelectedMode())
        return numberOfGames
    }
    
    
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

struct GameData {
    var score: Int
    var dateTime: String
}
