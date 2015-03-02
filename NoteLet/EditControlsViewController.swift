//
//  EditControlsViewController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/20/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import UIKit

class EditControlsViewController: UIViewController {

    var settingsControls: SettingsControlsController
    var synthControls: SynthControlsController
    var effectsControls: EffectsControlsController
    var editMenu: EditMenuController
    
    required init(coder aDecoder: NSCoder){
        var storyboard = UIStoryboard(name: "Instrument", bundle: nil)
        settingsControls = storyboard.instantiateViewControllerWithIdentifier("SettingsControls") as SettingsControlsController
        synthControls = storyboard.instantiateViewControllerWithIdentifier("SynthControls") as SynthControlsController
        effectsControls = storyboard.instantiateViewControllerWithIdentifier("EffectsControls") as EffectsControlsController
        editMenu = storyboard.instantiateViewControllerWithIdentifier("EditMenu") as EditMenuController

        super.init(coder: aDecoder)
        
        // Set up notification listeners
        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "moveToSynth:", name: "toggleSynth", object: nil)
        center.addObserver(self, selector: "moveToEffects:", name: "toggleEffects", object: nil)
        center.addObserver(self, selector: "moveToSettings:", name: "toggleSettings", object: nil)
        center.addObserver(self, selector: "moveToMenu:", name: "toggleMenu", object: nil)
    }
    
    deinit {
        var center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addChildViewController(settingsControls)
        self.addChildViewController(synthControls)
        self.addChildViewController(effectsControls)
        self.addChildViewController(editMenu)
        self.view.addSubview(editMenu.view)
        editMenu.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func moveToSynth(notification: NSNotification!){
        if let info = notification.userInfo as? Dictionary<String, UIView> {
            var view: UIView! = info["view"]
            view.removeFromSuperview()
            
            self.view.addSubview(synthControls.view)
            synthControls.didMoveToParentViewController(self)
        }
    }
    
    func moveToEffects(notification: NSNotification!){
        if let info = notification.userInfo as? Dictionary<String, UIView> {
            var view: UIView! = info["view"]
            view.removeFromSuperview()
            
            self.view.addSubview(effectsControls.view)
            effectsControls.didMoveToParentViewController(self)
        }
    }
    
    func moveToSettings(notification: NSNotification!){
        if let info = notification.userInfo as? Dictionary<String, UIView> {
            var view: UIView! = info["view"]
            view.removeFromSuperview()
            
            self.view.addSubview(settingsControls.view)
            settingsControls.didMoveToParentViewController(self)
        }
    }
    
    func moveToMenu(notification: NSNotification!){
        if let info = notification.userInfo as? Dictionary<String, UIView> {
            var view: UIView! = info["view"]
            view.removeFromSuperview()
            
            self.view.addSubview(editMenu.view)
            editMenu.didMoveToParentViewController(self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
