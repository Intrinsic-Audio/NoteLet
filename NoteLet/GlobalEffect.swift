//
//  GlobalEffect.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/17/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

@objc(GlobalEffect)
class GlobalEffect: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var receiver: String
    @NSManaged var value: NSNumber
    @NSManaged var composition: Composition

}
