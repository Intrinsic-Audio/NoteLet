//
//  Effect.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/10/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

@objc(Effect)
class Effect: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var value: NSNumber

}
