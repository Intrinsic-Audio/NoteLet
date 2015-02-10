//
//  Composition.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/10/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

@objc(Composition)
class Composition: NSManagedObject {

    // Relationships
    @NSManaged var noteEntities: NSSet
    @NSManaged var effects : NSSet
    
    // Audio Settings
    @NSManaged var scale : String
    
    // Tags and Identifiers
    @NSManaged var name: String

}
