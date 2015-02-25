//
//  EditMenuController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/24/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import UIKit

class EditMenuController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func toggleSynth(){
        var center = NSNotificationCenter.defaultCenter()
        center.postNotificationName("toggleSynth", object: nil, userInfo: ["view": self.view])
    }

    @IBAction func toggleEffects(){
        
    }
    
    @IBAction func toggleSettings(){
        
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
