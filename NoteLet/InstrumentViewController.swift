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
 
    var composition : Composition?

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initNotes(){
        var bounds : CGRect = self.view.bounds;
        
        if (composition!.noteEntities.count == 0){
            for var i : Float = 0.0; i < Float(bounds.width); i += 80.0 {
                var note : NoteEntity = NoteEntity.MR_createEntity() as NoteEntity
                note.centerX = i
                note.centerY = 100.0
                note.composition = composition!
                
                composition!.noteEntities.addObject(note)
                NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
                
                var noteView = NoteView(frame: CGRectMake(CGFloat(note.centerX),
                    CGFloat(note.centerY), 50.0, 50.0))
                self.view.addSubview(noteView)
            }
        } else {
            for note in composition!.noteEntities {
                var unwrappedNote = note as NoteEntity
                var noteView = NoteView(frame: CGRectMake(CGFloat(unwrappedNote.centerX),
                    CGFloat(unwrappedNote.centerY), 50.0, 50.0))
                self.view.addSubview(noteView)

            }
        }
    }
}