//
//  EditMenuController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/24/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import UIKit

class EditMenuController: UIViewController {
    
    @IBOutlet weak var currentNoteView: UIView!
    var currentNote: NoteView?
    
    var center = NSNotificationCenter.defaultCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentNoteView.userInteractionEnabled = false
        center.addObserver(self, selector: "updateCurrentNote:", name: "updateNote", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        center.removeObserver(self)
    }
    
    func updateCurrentNote(notification: NSNotification) {
        if let info = notification.userInfo as? Dictionary<String, Note> {
            let note = info["note"]
            
            println("\(currentNoteView.frame.origin)")
            
            if let curNote = currentNote {
                curNote.removeFromSuperview()
                currentNote = nil
            }
            
            currentNote = NoteView(frame: CGRectMake(20.0, 20.0, 60.0, 60.0), note: note!)
            
            println(currentNote!.frame.origin)
            
            currentNoteView.addSubview(currentNote!)
            
            println(note!.x)
        }
    }
    
    @IBAction func toggleSynth(){
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("toggleSynth", object: nil, userInfo: ["view": self.view])
    }

    @IBAction func toggleEffects(){
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("toggleEffects", object: nil, userInfo: ["view": self.view])
    }
    
    @IBAction func toggleSettings(){
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("toggleSettings", object: nil, userInfo: ["view": self.view])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
