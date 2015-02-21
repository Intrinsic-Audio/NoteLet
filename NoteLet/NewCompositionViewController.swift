//
//  NewCompositionViewController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/9/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import UIKit

class NewCompositionViewController : UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var keyControl: UISegmentedControl!
    @IBOutlet var scalePicker: UIPickerView!
    
    @IBOutlet var bpmLabel: UILabel!
    @IBOutlet var bpmSlider: UISlider!
    
    // Must match enumerated type ordering
    var scales = ["Major", "Minor", "Pentatonic"]
    
    var key = Key.C
    var scale = Scale.Major
    var bpm = 100
    
    var noteConfigType = NoteConfiguration.CircleOfFifths
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        self.scalePicker.delegate = self
        self.scalePicker.dataSource = self
    }
    
    //MARK: PickerView functions
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            return self.scales.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.scales[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row : Int, inComponent component : Int) {
        self.scale = Scale(rawValue: row)!
    }
    
    // MARK: Other IBActions
    
    @IBAction func selectKey(sender: UISegmentedControl) {
        // Forced unwrap b/c max index is 11
        self.key = Key(rawValue: sender.selectedSegmentIndex)!
    }
    
    @IBAction func setBPM(sender: UISlider) {
        self.bpm = Int(sender.value)
        self.bpmLabel.text = String(self.bpm)
    }
    
    // MARK: Segue
    
    @IBAction func createNewComposition(sender: UIButton) {
        var composition = Composition.MR_createEntity() as Composition
        composition.name = nameInput.text
        
        composition.details = GlobalAudioDetails.MR_createEntity() as GlobalAudioDetails
        composition.details.key = self.key.rawValue
        composition.details.scale = self.scale.rawValue
        composition.details.composition = composition
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        
        var storyboard = UIStoryboard(name: "Instrument", bundle: nil)
        var controller = storyboard.instantiateViewControllerWithIdentifier("InitialController") as InstrumentViewController
        controller.composition = composition
        
        self.presentViewController(controller, animated: true, completion: nil)
        
        controller.initNotes()
    }
}
