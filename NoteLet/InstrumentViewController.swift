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
 
    override func viewWillLayoutSubviews() {
        var bounds : CGRect = self.view.bounds;
        
        println("OK")
        
        for var i : CGFloat = 0.0; i < bounds.width; i += 40.0 {
            var note = NoteView(frame: CGRectMake(i, 100, 25.0, 25.0))
            self.view.addSubview(note)
        }
    }
    
}