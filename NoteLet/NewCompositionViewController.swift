//
//  NewCompositionViewController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/9/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import UIKit

class NewCompositionViewController : UIViewController {
    
    @IBOutlet var keySelect: UISegmentedControl!
    @IBOutlet var nameInput: UITextField!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func createNewComposition(sender: UIButton) {
        var composition = Composition.MR_createEntity() as Composition
        composition.name = nameInput.text
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
        var storyboard = UIStoryboard(name: "Instrument", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as InstrumentViewController
        controller.composition = composition
        controller.initNotes()
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
}
