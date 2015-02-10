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
    var composition : Composition!
    
    @IBAction func createNewComposition(sender: UIButton) {
        self.setupEntity()
        
        var storyboard = UIStoryboard(name: "Instrument", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as InstrumentViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func setupEntity() {
        composition = Composition.MR_createEntity() as Composition
        composition.name = nameInput.text
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
}
