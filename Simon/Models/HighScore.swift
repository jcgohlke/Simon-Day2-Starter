//
//  HighScore.swift
//  Simon
//
//  Created by Ben Gohlke on 5/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct HighScore: Codable {
    let initials: String
    let points: Int
    
    var score: String {
        return "\(points) pts"
    }
}
