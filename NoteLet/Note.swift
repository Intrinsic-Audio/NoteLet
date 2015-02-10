//
//  Note.swift
//  Hackathon2014
//
//  Created by Connor Taylor on 1/19/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

class Note: NSObject {

    var name: String = ""
    var midiNum: NSNumber = 60
    var centerX: NSNumber = 0.0
    var centerY: NSNumber = 0.0
    var waveID: NSNumber = 8
    var channelID: NSNumber = 0
    var hold: Bool = false
    var octave: NSNumber = 4
}
