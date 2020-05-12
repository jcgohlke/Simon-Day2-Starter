//
//  ColoredButton.swift
//  Simon
//
//  Created by Ben Gohlke on 4/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import AudioToolbox

class ColoredButton: UIButton {
    
    let lightUpTime: TimeInterval = 0.4
    
    var info: ButtonInfo! {
        didSet {
            backgroundColor = info.normalColor
        }
    }
    
    func lightUp() {
        AudioServicesPlaySystemSound(info.soundID)
        
        let animationBlock = {
            self.backgroundColor = self.info.brightColor
        }
        
        let completionBlock: (Bool) -> Void = { _ in
            UIView.animate(withDuration: self.lightUpTime) {
                self.backgroundColor = self.info.normalColor
            }
        }
        
        UIView.animate(withDuration: lightUpTime,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: animationBlock,
                       completion: completionBlock)
    }
}
