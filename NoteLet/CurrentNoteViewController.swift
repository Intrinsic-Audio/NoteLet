//
//  CurrentNoteViewController.swift
//  NoteLet
//
//  Created by Connor Taylor on 3/4/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import UIKit

class CurrentNoteViewController: UIViewController {

    @IBOutlet weak var currentNoteView: UIView!
    var currentNote:NoteView?
    
    var center = NSNotificationCenter.defaultCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentNoteView.userInteractionEnabled = false
        center.addObserver(self, selector: "updateCurrentNote:", name: "updateNote", object: nil)
        
        center.addObserver(self, selector: "removeNote:", name: "removeNote", object: nil)
        // Do any additional setup after loading the view.
    }
    
    deinit {
        center.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCurrentNote(notification: NSNotification) {
        if let info = notification.userInfo as? Dictionary<String, Note> {
            let note = info["note"]
                    
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
    
    func removeNote(notification: NSNotification) {
        if let note = currentNote {
            note.removeFromSuperview()
            currentNote = nil
        }
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
