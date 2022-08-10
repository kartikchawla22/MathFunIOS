//
//  HighScoreTableViewCell.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-27.
//

import UIKit

/// This class defines the table cell for the high score table
class HighScoreTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    /// Label to display date of game played.
    @IBOutlet weak var timeStamp: UILabel!
    
    /// Label to display score of a perticular game.
    @IBOutlet weak var score: UILabel!
    
    /// Label to show the game number
    @IBOutlet weak var indexLabel: UILabel!
}
