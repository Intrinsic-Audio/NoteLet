//
//  PlayControlsViewController.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/20/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import UIKit

class PlayControlsViewController: UIViewController {

    @IBOutlet var sliders: [EffectSlider]!
    @IBOutlet var toggles: [EffectButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var messages = [""]
        var effects = ["chorus", "tremolo", "delay", "filter", "ringmod"]
        var index = 0
        
        for button in toggles {
            button.effect = effects[index]
            index += 1
        }
        
        index = 0
        
        for slider in sliders {
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleEffect(sender: EffectButton) {
        sender.sendMessage()
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
