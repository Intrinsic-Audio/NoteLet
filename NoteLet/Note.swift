//
//  Note.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/17/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

@objc(Note)
class Note: NSManagedObject {

    @NSManaged var centerX: NSNumber
    @NSManaged var centerY: NSNumber
    @NSManaged var name: String
    @NSManaged var receiver: String
    @NSManaged var composition: Composition
    
    @NSManaged var details: NoteAudioDetails
    @NSManaged var effects: NSMutableSet

}
