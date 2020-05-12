//
//  GameBoardViewController.swift
//  Simon
//
//  Created by Ben Gohlke on 4/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import AudioToolbox

class GameBoardViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var redButton: ColoredButton!
    @IBOutlet weak var greenButton: ColoredButton!
    @IBOutlet weak var blueButton: ColoredButton!
    @IBOutlet weak var yellowButton: ColoredButton!
    
    @IBOutlet weak var endGameButton: UIButton!
    
    @IBOutlet weak var sequenceCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Properties
    
    var gameManager = GameManager()
    var scoreController: ScoreController?
    var timer: Timer?
    
    let buttonCornerRadius: CGFloat = 12.0

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This configures the button colors and their sounds
        configureButtons()
        scoreLabel.text = gameManager.score
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        resetForNewDemo()
    }
    
    // MARK: - Actions
    
    @IBAction func returnToMenu(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func coloredButtonTapped(_ sender: ColoredButton) {
        
    }
    
    private func gameOver() {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = ""
        }
        let quitAction = UIAlertAction(title: "", style: .cancel) { action in
            
        }
        alertController.addAction(quitAction)
    }
    
    // MARK: - Configuration
    
    private func configureButtons() {
        var blueButtonInfo = ButtonInfo(normalColor: blueButtonColor,
                                        brightColor: blueButtonBrightColor,
                                        sequenceColor: GameManager.SequenceColor.blue,
                                        soundUrl: CFBundleCopyResourceURL(CFBundleGetMainBundle(), "blue" as CFString, "mp3" as CFString, nil))
        blueButtonInfo.activateSystemSound()
        blueButton.info = blueButtonInfo
        blueButton.layer.cornerRadius = buttonCornerRadius
        
        var redButtonInfo = ButtonInfo(normalColor: redButtonColor,
                                        brightColor: redButtonBrightColor,
                                        sequenceColor: GameManager.SequenceColor.red,
                                        soundUrl: CFBundleCopyResourceURL(CFBundleGetMainBundle(), "red" as CFString, "mp3" as CFString, nil))
        redButtonInfo.activateSystemSound()
        redButton.info = redButtonInfo
        redButton.layer.cornerRadius = buttonCornerRadius
        
        var greenButtonInfo = ButtonInfo(normalColor: greenButtonColor,
                                        brightColor: greenButtonBrightColor,
                                        sequenceColor: GameManager.SequenceColor.green,
                                        soundUrl: CFBundleCopyResourceURL(CFBundleGetMainBundle(), "green" as CFString, "mp3" as CFString, nil))
        greenButtonInfo.activateSystemSound()
        greenButton.info = greenButtonInfo
        greenButton.layer.cornerRadius = buttonCornerRadius
        
        var yellowButtonInfo = ButtonInfo(normalColor: yellowButtonColor,
                                        brightColor: yellowButtonBrightColor,
                                        sequenceColor: GameManager.SequenceColor.yellow,
                                        soundUrl: CFBundleCopyResourceURL(CFBundleGetMainBundle(), "yellow" as CFString, "mp3" as CFString, nil))
        yellowButtonInfo.activateSystemSound()
        yellowButton.info = yellowButtonInfo
        yellowButton.layer.cornerRadius = buttonCornerRadius
        
        endGameButton.layer.cornerRadius = buttonCornerRadius
    }
    
    private func resetForNewDemo() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(demonstrateCycle), userInfo: nil, repeats: false)
    }
    
    // MARK: - Colored Sequence Playback
    
    @objc private func demonstrateCycle() {
        gameManager.demonstrationIndex = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(animateButton), userInfo: nil, repeats: true)
    }
    
    // MARK: - Animations
    
    @objc private func animateButton() {
        switch gameManager.nextColorToAnimate {
        case .red:
            redButton.lightUp()
        case .green:
            greenButton.lightUp()
        case .blue:
            blueButton.lightUp()
        case .yellow:
            yellowButton.lightUp()
        }
        
        if gameManager.demonstrationComplete {
            timer?.invalidate()
            timer = nil
        }
    }
}

struct ButtonInfo {
    let normalColor: UIColor
    let brightColor: UIColor
    let sequenceColor: GameManager.SequenceColor
    let soundUrl: CFURL
    var soundID: SystemSoundID = 0
    
    mutating func activateSystemSound() {
        AudioServicesCreateSystemSoundID(soundUrl, &soundID)
    }
}
