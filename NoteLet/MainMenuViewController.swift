//
//  MainMenuViewController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/8/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import UIKit

class MainMenuViewController : UIViewController {
    
    @IBAction func cancelCreation(segue: UIStoryboardSegue) {
        // Do nothing for now
    }
    
    @IBAction func cancelLoad(segue: UIStoryboardSegue) {
        // Do nothing for now
    }
    
    @IBAction func returnFromInstrument(segue: UIStoryboardSegue) {
        println("resetting")
        PdBase.sendMessage("reset", withArguments: [], toReceiver: "master")
    }
    
}