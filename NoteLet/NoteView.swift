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
    
    var patch = PdBase.openFile("wavetable_synth.pd", path: NSBundle.mainBundle().resourcePath)
    var dollarZero: Int32
    var isActive = false
    var playing = false
    var selected = false
    var touchStart: CGPoint?
    
    var notifCenter = NSNotificationCenter.defaultCenter()
    
    // Never called
    required init(coder aDecoder: NSCoder) {
        dollarZero = PdBase.dollarZeroForFile(patch)
        super.init(coder: aDecoder)
    }
    
    init(frame bounds: CGRect, note: Note){
        self.note = note
        dollarZero = PdBase.dollarZeroForFile(patch)

        super.init(frame: bounds)
        
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderColor = UIColor.blackColor().CGColor
        self.layer.borderWidth = 2
        
        var noteLabel = UILabel(frame: CGRectMake(24, 18, 25, 25))
        noteLabel.text = note.name
        noteLabel.textColor = UIColor.whiteColor()
        self.addSubview(noteLabel)
    
        notifCenter.addObserver(self, selector: "editModeChanged:", name: "toggleEditMode", object: nil)
        
        // Create red-blue gradient for notes
        var gradientLayer: RadialGradientLayer = RadialGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.width / 2

        self.layer.insertSublayer(gradientLayer, atIndex: 0)
        gradientLayer.setNeedsDisplay()
        
    }
    
    deinit {
        PdBase.closeFile(patch)
        notifCenter.removeObserver(self)
    }

    func editModeChanged(notification: NSNotification){
        self.editMode = !self.editMode
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch: UITouch = touches.anyObject() as UITouch
        touchStart = touch.locationInView(self)
        
        notifCenter.postNotificationName("updateNote", object: nil, userInfo: ["note": note])
        
        // start playing the note
        if !self.editMode {
            self.play()
        }
    }
    
    func play() {
        var receiver = String(dollarZero) + "-note"
        println(receiver)
        
        PdBase.sendList([50, 50], toReceiver: receiver)
        
        var animation = CABasicAnimation(keyPath: "transform.scale")
        animation.repeatCount = HUGE
        animation.autoreverses = false
        animation.duration = 0.3
        animation.fromValue = 1.0
        animation.toValue = 0.3
        self.layer.addAnimation(animation, forKey: "animatePlaying")
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
        println("\(xdiff) \(ydiff)")
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent){
        if self.editMode {
            self.note.x = self.frame.origin.x
            self.note.y = self.frame.origin.y
            
            self.saveNotePosition()
        } else {
            self.stop()
        }
    }
    
    func stop () {
        var receiver = String(dollarZero) + "-note"
        println(receiver)
        PdBase.sendList([50, 0], toReceiver: receiver)
        
        self.layer.removeAllAnimations()
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
}