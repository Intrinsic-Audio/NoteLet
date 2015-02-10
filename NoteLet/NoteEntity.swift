//
//  NoteEntity.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/10/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

@objc(NoteEntity)
class NoteEntity: NSManagedObject {

    // Relationships
    @NSManaged var composition : Composition
    @NSManaged var effects : NSSet

    // Audio configuration
    @NSManaged var midiNumber : Int16
    @NSManaged var waveformID : Int16
    
    // Positioning
    @NSManaged var centerX : NSNumber
    @NSManaged var centerY : NSNumber
    
    // Pd receiver to send to
    @NSManaged var receiver : String
    
    // Tags
    @NSManaged var name : String
}
