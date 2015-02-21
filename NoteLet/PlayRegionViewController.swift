//
//  PlayRegionViewController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/20/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import UIKit

class PlayRegionViewController: UIViewController {

    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "editModeChanged:", name: "toggleEditMode", object: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initNotes(composition: Composition){
        var bounds : CGRect = self.view.bounds;
        
        if (composition.notes.count == 0){
            
            let coordinates = self.getPresetCoordinates()
            
            for var i : Float = 0.0; i < Float(bounds.width); i += 80.0 {
                var note : Note = Note.MR_createEntity() as Note
                note.centerX = i
                note.centerY = 100.0
                note.composition = composition
                
                composition.notes.addObject(note)
                NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
                
                var noteView = NoteView(frame: CGRectMake(CGFloat(note.centerX),
                    CGFloat(note.centerY), 60.0, 60.0))
                self.view.addSubview(noteView)
            }
        } else {
            for note in composition.notes {
                var unwrappedNote : Note = note as Note
                var noteView = NoteView(frame: CGRectMake(CGFloat(unwrappedNote.centerX),
                    CGFloat(unwrappedNote.centerY), 60.0, 60.0))
                self.view.addSubview(noteView)
                
            }
        }
    }
    
    func getPresetCoordinates() -> Array<Int> {
        return []
    }
    
    func editModeChanged(notification : NSNotification){
        self.editMode = !self.editMode
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
