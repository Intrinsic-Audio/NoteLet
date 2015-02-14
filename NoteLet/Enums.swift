//
//  Enums.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/13/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation

enum Note : Int16 {
    case C = 0, Db, D, Eb, E, F, Gb, G, Ab, A, Bb, B
}

enum Scale {
    case Major(Int, Int, Int, Int, Int, Int, Int)
    case Minor(Int, Int, Int, Int, Int, Int, Int)
    case Pentatonic(Int, Int, Int, Int, Int)
}