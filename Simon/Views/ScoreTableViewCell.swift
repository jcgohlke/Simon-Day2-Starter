//
//  ScoreTableViewCell.swift
//  Simon
//
//  Created by Ben Gohlke on 5/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    static let reuseIdentifier = "ScoreCell"
    var score: HighScore? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        guard let score = score else { return }
        
        initialsLabel.text = score.initials.uppercased()
        scoreLabel.text = score.score
    }
}
