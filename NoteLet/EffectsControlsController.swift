//
//  EffectsControlsController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/24/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import UIKit

class EffectsControlsController: UIViewController {

    @IBOutlet weak var modulationType: UISegmentedControl!
    var center = NSNotificationCenter.defaultCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleMenu(){
        center.postNotificationName("toggleMenu", object: nil, userInfo: ["view": self.view])
    }

    @IBAction func addModEffect(sender: UIButton) {
        var axis = modulationType.selectedSegmentIndex // 0 for vert, 1 for horz
        
        var parentVC = self.parentViewController as EditControlsViewController
        
        println(parentVC.currentNote!)
        
        if let note = parentVC.currentNote {
            println("sending notif")
            
            var id = note.id
            center.postNotificationName("updateModEffect", object: nil,
                userInfo: ["axis": axis, "effect": sender.tag, "id": id])

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
