//
//  Enums.swift
//  NoteLet
//
//  Created by Connor Taylor on 2/13/15.
//  Copyright (c) 2015 Intrinsic Audio. All rights reserved.
//

import Foundation

// Mappings of key and scale ids to readable types

// Swift doesnt support '#' in variable names, have to use flats
enum Key : NSNumber {
    case C = 0, Db, D, Eb, E, F, Gb, G, Ab, A, Bb, B
}

enum Scale : NSNumber {
    case Major = 0, Minor, Pentatonic
}

enum NoteConfiguration {
    case LoadedPositions
    case CircleOfFifths
    case Chords
    case Spiral
}

func getScale(scale: Scale) -> [Int]{
    switch scale {
    case .Major:
        return [2, 2, 1, 2, 2, 2, 1]
    case .Minor:
        return [2, 1, 2, 2, 2, 1, 2]
    case .Pentatonic:
        return [2, 2, 2, 2, 2]
    }
}