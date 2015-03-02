//
//  GlobalAudioDetails.swift
//  NoteLet
//
//  Created by Connor Taylor on 3/1/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation
import CoreData

@objc(GlobalAudioDetails)
class GlobalAudioDetails: NSManagedObject {

    @NSManaged var bpm: NSNumber
    @NSManaged var key: NSNumber
    @NSManaged var scale: NSNumber
    @NSManaged var composition: Composition

}
