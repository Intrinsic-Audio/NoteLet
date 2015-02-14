//
//  NoteView.swift
//  Hackathon2014
//
//  Created by Connor Taylor on 1/19/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import UIKit

class NoteView : UIView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame bounds: CGRect){
        super.init(frame: bounds)
        
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2
        self.backgroundColor = UIColor.redColor()
    }
}

//class NoteView : UIView {
//    
//    var playing = false
//    var selected = false
//    var note = Note()
//    var color : UIColor = UIColor.whiteColor()
//    
//    init(frame aRect: CGRect,
//        noteNum midiNum: NSNumber,
//        octave noteOctave: NSNumber,
//        channelID id: NSNumber) {
//        
//            super.init(frame: aRect)
//            var width = frame.size.width
//            var height = frame.size.height
//            
//            println("\(noteOctave) \(midiNum)")
//            
//            note.octave = noteOctave
//            note.midiNum = midiNum
//            note.centerX = self.frame.origin.x
//            note.centerY = self.frame.origin.y
//            note.hold = false
//            note.waveID = 1
//            note.name = "C"
//            
//            self.layer.cornerRadius = self.frame.size.width / 2
//            self.layer.borderColor = UIColor.blackColor().CGColor
//            self.layer.borderWidth = 2
//            
//            setNoteName()
//            setBackgroundColor()
//            
//            var noteLabel = UILabel(frame: CGRectMake(width / 4 + 10, height / 4, width / 2, height / 2))
//            noteLabel.text = note.name
//            
//            self.addSubview(noteLabel)
//    }
//    
//    required init(coder: NSCoder) {
//        note = Note()
//        super.init(coder: coder)
//    }
//    
//    func setNoteName() {
//        switch note.midiNum {
//        case 0:
//            note.name = "C"
//        case 1:
//            note.name = "C#"
//        case 2:
//            note.name = "D"
//        case 3:
//            note.name = "D#"
//        case 4:
//            note.name = "E"
//        case 5:
//            note.name = "F"
//        case 6:
//            note.name = "F#"
//        case 7:
//            note.name = "G"
//        case 8:
//            note.name = "G#"
//        case 9:
//            note.name = "A"
//        case 10:
//            note.name = "A#"
//        case 11:
//            note.name = "B"
//        default:
//            NSLog("Unsupported Midi Number")
//        }
//    }
//    
//    func setBackgroundColor() {
//        switch note.octave {
//        case 1:
//            self.color = UIColor(red: 34.0 / 255.0, green:68.0 / 255.0, blue:85.0 / 255.0, alpha:0.1)
//        case 2:
//            self.color = UIColor(red: 214.0 / 255.0, green:51.0 / 255.0, blue:51.0 / 255.0, alpha:0.2)
//        case 3:
//            self.color = UIColor(red: 10 / 255.0, green:50 / 255.0, blue:70 / 255.0, alpha:0.525)
//        case 4:
//            self.color = UIColor(red: 78.0 / 255.0, green:118.0 / 255.0, blue:134.0 / 255.0, alpha:1.0)
//        case 5:
//            self.color = UIColor(red: 85.0 / 255.0, green:170.0 / 255.0, blue:170.0 / 255.0, alpha:1.0)
//        case 6:
//            self.color = UIColor(red: 169.0 / 255.0, green:204.0 / 255.0, blue:127.0 / 255.0, alpha:1.0)
//        case 7:
//            self.color = UIColor(red: 25.0 / 255.0, green:209.0 / 255.0, blue:255.0 / 255.0, alpha:1.0)
//        default:
//            NSLog("Unsupported Octave")
//        }
//    }
//    
//    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
//        
//    }
//    
//    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
//        
//    }
//    
//    override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
//        
//    }
//    
//    func play() {
//        if playing {
//            self.layer.removeAllAnimations()
//            playing = true
//        } else {
//            var data = ["note", note.midiNum, 50]
//            
//            var animation = CABasicAnimation(keyPath: "transform.scale")
//            animation.duration = 0.3
//            animation.repeatCount = Float.infinity
//            animation.autoreverses = false
//            animation.fromValue = 1.0
//            animation.toValue = 0.3
//            self.layer.addAnimation(animation, forKey:"playing")
//            
//            playing = false
//        }
//    }
//    
//    func select() {
//        
//        if selected {
//            self.layer.removeAllAnimations()
//            selected = false
//        } else {
//            var color : CABasicAnimation  = CABasicAnimation(keyPath: "borderColor")
//            color.fromValue = UIColor.blackColor().CGColor
//            color.toValue = UIColor.redColor().CGColor
//            
//            var width : CABasicAnimation  = CABasicAnimation(keyPath: "borderWidth")
//            width.fromValue = 2;
//            width.toValue   = 6;
//            
//            var both : CAAnimationGroup = CAAnimationGroup()
//            both.duration = 0.25
//            both.autoreverses = true
//            both.repeatCount = Float.infinity
//            both.animations = [color, width]
//            
//            selected = true
//        }
//    }
//    
//    func stop() {
//        
//    }
//    
//    func bendPitch() {
//        
//    }
//    
//    func scalePitchBend(bend: Float) -> Float{
//        return 64 * pow(bend, 3.0) + 64
//    }
//    
//    func scaleVolumeBend(bend: Float) {
//        
//    }
//}