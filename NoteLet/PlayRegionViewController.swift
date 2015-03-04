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
    var patch = PdBase.openFile("master.pd", path: NSBundle.mainBundle().resourcePath)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "editModeChanged:", name: "toggleEditMode", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        var center = NSNotificationCenter.defaultCenter()
        center.removeObserver(self)
    }
    
    func initNotes(composition: Composition, config: NoteConfiguration){
        var bounds : CGRect = self.view.bounds;

        if (composition.notes.count == 0){
            self.createNotes(config, composition: composition)
        } else {
            for note in composition.notes {
                var unwrappedNote : Note = note as Note
                var noteView = NoteView(frame: CGRectMake(CGFloat(unwrappedNote.x),
                    CGFloat(unwrappedNote.y), 60.0, 60.0), note: unwrappedNote)
                self.view.addSubview(noteView)
            }
        }
    }
    
    func createNotes(config: NoteConfiguration, composition: Composition) {
        switch config {
        case .LoadedPositions:
            println("foo")
        case .CircleOfFifths:
            println("foo")
        case .Chords:
            self.makeChordPosition(composition)
        case .Spiral:
            println("foo")
        }
    }
    
    func makeChordPosition(composition: Composition) {
        var x = 60.0
        var y = 60.0
        
        var major = [2, 2, 1, 2, 2, 2, 1]
        // Start at C
        var midiNote = 0
        var scale_index = 0
        var octave = 2
        var scale_len = major.count
        
        // Create 4 rows of 2 chords.  Each chord has 2 octaves and 4 notes
        for var rows = 0; rows < 4; rows += 1 {
            for var chords = 0; chords < 2; chords += 1 {
                for var octaves = 0; octaves < 2; octaves += 1 {
                    for var notes = 0; notes < 4; notes += 1 {
                        var note : Note = Note.MR_createEntity() as Note
                        note.x = x
                        note.y = y
                        note.name = self.getNoteName(midiNote)
                        
                        println(scale_index)
                        
                        midiNote = (midiNote + major[scale_index]) % 12
                        scale_index = ((scale_index + 1) % scale_len + 1 % scale_len)
                        
                        
                        note.composition = composition
                        
                        composition.notes.addObject(note)
                        var noteView = NoteView(frame: CGRectMake(CGFloat(note.x),
                            CGFloat(note.y), 60.0, 60.0), note: note)
                        self.view.addSubview(noteView)
                        
                        x += 70.0
                    }
                    scale_index -= 5
                    x -= 280.0
                    y += 70.0
                }
                x += 350.0
                y -= 140.0
            }
            y += 170.0
            x = 60.0
            
            println("x: \(x) y: \(y)")
        }
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
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
    
    func getNoteName(midiNum: Int) -> String{
        switch midiNum {
        case 0:
            return "C"
        case 1:
            return "C#"
        case 2:
             return "D"
        case 3:
            return "D#"
        case 4:
            return "E"
        case 5:
            return "F"
        case 6:
            return "F#"
        case 7:
            return "G"
        case 8:
            return "G#"
        case 9:
            return "A"
        case 10:
            return "A#"
        case 11:
            return "B"
        default:
            return "?"
        }
    }

}
