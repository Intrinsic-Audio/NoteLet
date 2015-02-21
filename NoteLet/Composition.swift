//
//  Composition.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/17/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

@objc(Composition)
class Composition: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var effects: NSMutableSet
    @NSManaged var notes: NSMutableSet
    @NSManaged var details: GlobalAudioDetails

}
