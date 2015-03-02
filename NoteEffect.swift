//
//  NoteEffect.swift
//  NoteLet
//
//  Created by Connor Taylor on 3/1/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

@objc(NoteEffect)
class NoteEffect: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var receiver: String
    @NSManaged var value: NSNumber
    @NSManaged var min: NSNumber
    @NSManaged var max: NSNumber
    @NSManaged var note: Note

}
