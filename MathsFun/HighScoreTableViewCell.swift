//
//  HighScoreTableViewCell.swift
//  MathsFun
//
//  Created by Kartik Chawla on 2022-07-27.
//

import UIKit

class HighScoreTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var indexLabel: UILabel!
    
    
    // MARK: - Class Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
