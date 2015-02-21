//
//  InstrumentViewController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/8/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import UIKit

class InstrumentViewController : UIViewController {
 
    // Be sure to set this after initializing the controller.
    var composition : Composition!
    var playRegion : PlayRegionViewController!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    // Will fail if called before setting composition
    func initNotes(){
        self.playRegion.initNotes(self.composition)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PlayRegion" {
            self.playRegion = segue.destinationViewController as PlayRegionViewController
        }
    }
}