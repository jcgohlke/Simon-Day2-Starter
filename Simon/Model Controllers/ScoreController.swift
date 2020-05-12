//
//  ScoreController.swift
//  Simon
//
//  Created by Ben Gohlke on 5/3/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class ScoreController {
    
    private(set) var scores: [HighScore] = []
    
    init() {
        loadScores()
    }
    
    func createScore(withInitials initials: String, score: Int) {
        let score = HighScore(initials: initials, points: score)
        scores.append(score)
        scores.sort { $0.points > $1.points }
        saveScores()
    }
    
    // MARK: - Persistence
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("scores.plist")
    }
    
    private func loadScores() {
        let fm = FileManager.default
        guard let url = persistentFileURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            scores = try decoder.decode([HighScore].self, from: data)
        } catch {
            NSLog("Error loading scores: \(error)")
        }
    }

    private func saveScores() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(scores)
            try data.write(to: url)
        } catch {
            NSLog("Error saving scores: \(error)")
        }
    }
}
