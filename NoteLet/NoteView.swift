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
    
    var editMode = false
    var note: Note!
    
    var isActive = false
    var touched = false
    
    var playing = false
    var selected = false
    var touchStart: CGPoint?
    
    var scaledNote: NSNumber
    var id = 1
    
    var notifCenter = NSNotificationCenter.defaultCenter()
    
    // Never called, will fail if it is
    required init(coder aDecoder: NSCoder) {
        scaledNote = Int(note.details.midiNumber) + (Int(note.details.note.details.octave) * 12)

        super.init(coder: aDecoder)
    }
    
    init(frame bounds: CGRect, note: Note){
        self.note = note
        scaledNote = Int(note.details.midiNumber) + (Int(note.details.note.details.octave) * 12)

        super.init(frame: bounds)
        
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2
        
        var noteLabel = UILabel(frame: CGRectMake(24, 18, 25, 25))
        noteLabel.text = note.name
        noteLabel.textColor = UIColor.whiteColor()
        self.addSubview(noteLabel)
    
        notifCenter.addObserver(self, selector: "editModeChanged:", name: "toggleEditMode", object: nil)
        notifCenter.addObserver(self, selector: "pitchChanged:", name: "updatePitch", object: nil)

        
        
        // Create red-blue gradient for notes
        var gradientLayer: RadialGradientLayer = RadialGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.width / 2

        self.layer.insertSublayer(gradientLayer, atIndex: 0)
        gradientLayer.setNeedsDisplay()
    }
    
    deinit {
        notifCenter.removeObserver(self)
    }

    func editModeChanged(notification: NSNotification){
        self.editMode = !self.editMode
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch: UITouch = touches.anyObject() as UITouch
        touchStart = touch.locationInView(self)
        
        notifCenter.postNotificationName("updateNote", object: nil, userInfo: ["note": self])
        
        // start playing the note
        if !self.editMode {
            if self.playing{
                self.stop()
            } else {
                self.play()
            }
            
            self.isActive = true
        } else {
            self.select()
        }
    }
    
    func play() {
        var receiver = "note" + String(id)
        println(scaledNote)
        PdBase.sendList([scaledNote, 50], toReceiver: receiver)
        
        var animation = CABasicAnimation(keyPath: "transform.scale")
        animation.repeatCount = HUGE
        animation.autoreverses = false
        animation.duration = 0.3
        animation.fromValue = 1.0
        animation.toValue = 0.3
        self.layer.addAnimation(animation, forKey: "animatePlaying")
        self.playing = true
    }
    
    func select(){
        if self.selected {
            self.layer.removeAllAnimations()
        } else {
            var borderColor = CABasicAnimation(keyPath: "borderColor")
            borderColor.fromValue = UIColor.blackColor().CGColor
            borderColor.toValue = UIColor.yellowColor().CGColor
            
            var borderWidth = CABasicAnimation(keyPath: "borderWidth")
            borderWidth.fromValue = 2
            borderWidth.toValue = 6
            
            var group = CAAnimationGroup()
            group.duration = 0.25
            group.autoreverses = true
            group.repeatCount = HUGE
            group.animations = [borderWidth, borderColor]
            self.layer.addAnimation(group, forKey: "color and width")
    
        }
        
        self.selected = !self.selected
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent){
        var touch: UITouch = touches.anyObject() as UITouch
        var width = self.frame.width
        var height = self.frame.height
        var touchPoint: CGPoint = touch.locationInView(self)
        
        if self.editMode {
            var newCenter = CGPoint(x: center.x + touchPoint.x - width / 2, y: center.y + touchPoint.y - height / 2)
            self.reposition(newCenter)
        } else {
            self.bendWithXdiff(touchPoint.x - touchStart!.x, ydiff: touchStart!.y - touchPoint.y )
        }
    }
    
    func bendWithXdiff(xdiff: CGFloat, ydiff: CGFloat){
        var convertedY = ydiff * 0.33 + 64
        
        if convertedY > 127{
            convertedY = 127
        } else if convertedY < 0 {
            convertedY = 0
        }
        
        var receiver = "note" + String(id)
        PdBase.sendMessage("pitchbend", withArguments: [convertedY], toReceiver: receiver)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent){
        if self.editMode {
            self.note.x = self.frame.origin.x
            self.note.y = self.frame.origin.y
            
            self.saveNotePosition()
        } else {
            if !Bool(note.details.hold) && self.playing {
                self.stop()
            }
        }
        
        self.isActive = false
    }
    
    func stop () {
        var receiver = "note" + String(id)
        PdBase.sendList([scaledNote, 0], toReceiver: receiver)
        
        self.layer.removeAllAnimations()
        self.playing = false
    }

    func saveNotePosition(){
        var note = self.note
        var x = self.frame.origin.x
        var y = self.frame.origin.y
        
        MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) in
            var localNote: Note = note.MR_inContext(localContext) as Note
            localNote.x = x
            localNote.y = y
        })
    }
    
    func reposition(newCenter: CGPoint){
        UIView.animateWithDuration(0.05, animations: {
            self.center = newCenter
        })
    }
    
    func modeChange() {        
        self.layer.removeAllAnimations()
        self.selected = false
        
        if self.playing {
            var receiver = "note" + String(id)
            PdBase.sendList([scaledNote, 0], toReceiver: receiver)
        }
    }
}