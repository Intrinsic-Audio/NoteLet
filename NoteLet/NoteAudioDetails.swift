//
//  NoteAudioDetails.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/17/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

@objc(NoteAudioDetails)
class NoteAudioDetails: NSManagedObject {

    @NSManaged var hold: NSNumber
    @NSManaged var midiNumber: NSNumber
    @NSManaged var octave: NSNumber
    @NSManaged var waveformId: NSNumber
    @NSManaged var note: Note

}
