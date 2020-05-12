//
//  MenuViewController.swift
//  Simon
//
//  Created by Ben Gohlke on 4/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var scoreController = ScoreController()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewGameButton.layer.cornerRadius = 12
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameBoardModalSegue" {
            if let gameBoardVC = segue.destination as? GameBoardViewController {
                gameBoardVC.scoreController = scoreController
            }
        }
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreController.scores.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.reuseIdentifier, for: indexPath) as? ScoreTableViewCell else {
            fatalError("Could not dequeue cell with identifier: \(ScoreTableViewCell.reuseIdentifier)")
        }

        cell.score = scoreController.scores[indexPath.row]

        return cell
    }
}
