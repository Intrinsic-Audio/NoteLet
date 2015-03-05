//
//  EffectSlider.swift
//  Hackathon2014
//
//  Created by Connor Taylor on 1/17/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation

class EffectSlider : UIView {
    var fill = UIView()
    var currentWidth:CGFloat = 0.0
    var receiver = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        var fillFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        fill = UIView(frame: fillFrame)
        fill.backgroundColor = UIColor.redColor()
        
        
        self.layer.cornerRadius = self.frame.size.height / 2
        self.fill.layer.cornerRadius = self.fill.frame.size.height / 2
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var touchPoint = touch.locationInView(self)
        
        self.updateValue(touchPoint)
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var touchPoint = touch.locationInView(self)
        
        self.updateValue(touchPoint)
    }
    
    func updateFill(touchPoint: CGPoint){
        var newWidth = touchPoint.x - self.fill.frame.origin.x
        
        if newWidth > self.frame.size.width {
            newWidth = self.frame.size.width
        } else if newWidth < 0 {
            newWidth = 0
        }
        
        self.fill.frame = CGRectMake(0, 0, newWidth, self.frame.size.height)
        currentWidth = newWidth
    }
    
    func updateValue(touchPoint: CGPoint) {
        var scaleFactor = currentWidth / self.frame.size.width
        
        var value = 127 * scaleFactor
        
    }
}