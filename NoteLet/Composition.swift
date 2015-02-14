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
    @NSManaged var noteEntities: NSMutableSet
    @NSManaged var effects : NSMutableSet
    
    // Audio Settings
    @NSManaged var key : Int16
    @NSManaged var scale : Int16
    
    // Tags and Identifiers
    @NSManaged var name: String

}
