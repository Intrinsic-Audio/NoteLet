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
    var composition: Composition!
    var noteViews: [NoteView] = []
    
    var validID = 1
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
        self.composition = composition

        if (composition.notes.count == 0){
            self.createNotes(config)
        } else {
            for note in composition.notes {
                var unwrappedNote : Note = note as Note
                var noteView = NoteView(frame: CGRectMake(CGFloat(unwrappedNote.x),
                    CGFloat(unwrappedNote.y), 60.0, 60.0), note: unwrappedNote)
                self.view.addSubview(noteView)
            }
        }
    }
    
    func createNotes(config: NoteConfiguration) {
        switch config {
        case .LoadedPositions:
            println("foo")
        case .CircleOfFifths:
            println("foo")
        case .Chords:
            self.makeChordPosition()
        case .Spiral:
            println("foo")
        }
    }
    
    func makeChordPosition() {
        var x = 60.0
        var y = 60.0
        
        var major = [2, 2, 1, 2, 2, 2, 1]
        // Start at C
        var midiNote = 0
        var currentMidiNote = 0
        
        var scale_index = 0
        var currentChord = 0
        var nextChord = 1
        var octave = 2
        
        // Add 1 since we're modding on this
        var scale_len = major.count
        
        // Create 4 rows of 2 chords.  Each chord has 2 octaves and 4 notes
        for var rows = 0; rows < 4; rows += 1 {
            for var chords = 0; chords < 2; chords += 1 {
                for var octaves = 0; octaves < 2; octaves += 1 {
                    for var notes = 0; notes < 4; notes += 1 {
                        
                        // Create the entities and ensure they are saved before setting positions
                        var note : Note = Note.MR_createEntity() as Note
                        var noteDetails = NoteAudioDetails.MR_createEntity() as NoteAudioDetails
                        noteDetails.note = note
                        note.details = noteDetails
                        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
                        
                        note.x = x
                        note.y = y
                        note.name = getNoteName(midiNote)
                        
                        midiNote = (midiNote + major[scale_index]) % 12
                        midiNote = (midiNote + major[(scale_index + 1) % scale_len]) % 12
                        
                        note.details.midiNumber = midiNote
                        note.details.octave = octaves + 4
                        note.composition = composition
                        
                        MagicalRecord.saveWithBlock({ (localContext: NSManagedObjectContext!) in
                            var localNote: Note = note.MR_inContext(localContext) as Note
                            var localComposition = self.composition.MR_inContext(localContext) as Composition
                            var localDetails = note.details.MR_inContext(localContext)  as NoteAudioDetails
                            
                            localNote.x = x
                            localNote.y = y
                            localNote.name = note.name
                            
                            localDetails.midiNumber = midiNote
                            localDetails.octave = octaves + 4
                            
                            localNote.composition = localComposition
                            localComposition.notes.addObject(note)
                        })
                        
                        scale_index = (scale_index + 2) % scale_len
                        
                        var noteView = NoteView(frame: CGRectMake(CGFloat(note.x),
                            CGFloat(note.y), 60.0, 60.0), note: note)
                        
                        PdBase.sendMessage("new", withArguments: [], toReceiver: "master")
                        noteView.id = validID
                        validID += 1
                        
                        self.noteViews.append(noteView)
                        self.view.addSubview(noteView)
                        
                        x += 70.0
                    }
                    scale_index = currentChord
                    midiNote = currentMidiNote
                    x -= 280.0
                    y += 70.0
                }
                currentMidiNote = (currentMidiNote + major[scale_index]) % 12
                midiNote = currentMidiNote
                
                scale_index = nextChord
                currentChord = nextChord
                nextChord = (nextChord + 1) % scale_len

                x += 350.0
                y -= 140.0
            }
            y += 170.0
            x = 60.0
        }
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
    func editModeChanged(notification : NSNotification){
        self.editMode = !self.editMode
        
        println("killing animations")

        for noteView in noteViews {
            noteView.modeChange()
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        var touch = touches.anyObject() as UITouch
        var touchPoint = touch.locationInView(self.view)
        
        var tappedNotes = self.getIntersectsInEvent(event)
        var untappedNotes = self.getNonIntersectsInEvent(event)
        
        for note in tappedNotes {
            if !note.touched {
                if self.editMode {
                    note.select()
                } else {
                    if note.playing {
                        note.stop()
                    } else {
                        note.play()
                    }
                }
            }
            
            note.touched = true
        }
        
        for note in untappedNotes {
            if !self.editMode && !Bool(note.note.details.hold) && note.playing {
                note.stop()
            }
            note.touched = false
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        var touchPoint = touch.locationInView(self.view)
        
        var tappedNotes = self.getIntersectsInEvent(event)
        var untappedNotes = self.getNonIntersectsInEvent(event)
        
        for note in tappedNotes {
            if !self.editMode {
                note.stop()
            }
        }
        
        for note in untappedNotes {
            if !self.editMode && !Bool(note.note.details.hold) && note.playing{
                note.stop()
            }
            note.touched = false
        }
    }
    
    func getIntersectsInEvent(event: UIEvent) -> [NoteView] {
        var touchRects: [CGRect] = []
        var notes: [NoteView] = []
        var eventTouches = event.allTouches()
        
        if let touches = eventTouches {
            for touch in touches {
                var touchLocation = touch.locationInView(self.view)
                var touchRect = CGRectMake(touchLocation.x, touchLocation.y, 0, 0)
                touchRects.append(touchRect)
            }
        }
        
        for noteView in noteViews {
            var noteRect = noteView.frame
            for touchRect in touchRects{
                if CGRectIntersectsRect(touchRect, noteRect){
                    notes.append(noteView)
                }
            }
        }
        return notes
    }
    
    func getNonIntersectsInEvent(event: UIEvent) -> [NoteView] {
        var notes: [NoteView] = []
        var touchRects: [CGRect] = []
        var eventTouches = event.allTouches()
        
        if let touches = eventTouches {
            for touch in touches {
                var touchLocation = touch.locationInView(self.view)
                var touchRect = CGRectMake(touchLocation.x, touchLocation.y, 0, 0)
                touchRects.append(touchRect)
            }
        }
        
        for noteView in noteViews {
            var noteRect = noteView.frame
            var shouldAdd = true

            for touchRect in touchRects {
                if CGRectIntersectsRect(touchRect, noteRect) || noteView.isActive {
                    shouldAdd = false
                }
            }
            if shouldAdd {
                notes.append(noteView)
            }
        }
        
        return notes
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
