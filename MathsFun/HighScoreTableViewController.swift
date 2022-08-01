//
//  HighScoreTableViewController.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-27.
//

import UIKit

class HighScoreTableViewController: UITableViewController {
    let gameModel = GameModel.shared
    var gameDataArr = [GameData]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        tableView.reloadData()
        title = gameModel.getSelectedMode() + " Game"
    }
    
    // MARK: - Table view data source
    
    func loadData(){
        let numberOfGames = UserDefaults.standard.integer(forKey: Constants.NUM_GAMES + gameModel.getSelectedMode())
        for i in (0..<numberOfGames) {
            let gameNumber = i + 1
            let score = UserDefaults.standard.integer(forKey: String(Constants.SCORE)  + gameModel.getSelectedMode() + String(gameNumber))
            let dateTime = UserDefaults.standard.string(forKey: String(Constants.DATE_TIME)  + gameModel.getSelectedMode() + String(gameNumber))
            print(String(Constants.DATE_TIME)  + gameModel.getSelectedMode() + String(gameNumber))
            let thisGameData = GameData(score: score, dateTime: dateTime!)
            gameDataArr.append(thisGameData)
        }
    }
    
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
        print(thisRowData)
        cell.indexLabel.text = String(indexPath.row + 1)
        cell.score.text = String(thisRowData.score)
        cell.timeStamp.text = thisRowData.dateTime
        return cell
    }
}
struct GameData {
    var score: Int
    var dateTime: String
}
