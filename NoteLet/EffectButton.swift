//
//  EffectButton.swift
//  Hackathon2014
//
//  Created by Connor Taylor on 1/17/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation

class EffectButton: UIButton {
    var receiver = "effects"
    var effect = ""
    var toggled = 1
    
    func sendMessage(){
        PdBase.sendMessage(effect, withArguments: ["on", toggled], toReceiver: "effects")
        
        if Bool(toggled) {
            toggled = 0
            
            UIView.animateWithDuration(0.2, animations: {
                self.backgroundColor = UIColor.greenColor()
                self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            })
        } else {
            toggled = 1
            UIView.animateWithDuration(0.2, animations: {
                self.backgroundColor = UIColor.redColor()
                self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            })
        }
    }
}
