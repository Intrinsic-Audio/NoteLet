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

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initNotes(){
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
                    CGFloat(note.centerY), 50.0, 50.0))
                self.view.addSubview(noteView)
            }
        } else {
            for note in composition.notes {
                var unwrappedNote : Note = note as Note
                var noteView = NoteView(frame: CGRectMake(CGFloat(unwrappedNote.centerX),
                    CGFloat(unwrappedNote.centerY), 50.0, 50.0))
                self.view.addSubview(noteView)

            }
        }
    }
    
    func getPresetCoordinates() -> Array<Int> {
        return []
    }
}