//
//  ControlsViewController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/20/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import UIKit

class ControlsViewController: UIViewController {

    var editMode = false
    var container : ControlsContainerViewController!


    required init(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleEditMode(button : UIButton){
        if (self.editMode){
            button.setTitle("Edit", forState: UIControlState.Normal)
        } else {
            button.setTitle("Play", forState: UIControlState.Normal)
        }
        
        self.container.swapViewControllers()
        self.editMode = !self.editMode
        
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("toggleEditMode", object: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedContainer" {
            self.container = segue.destinationViewController as ControlsContainerViewController
        }
        
        // Get the new view controller using segue.destinationViewController.
    }

}
