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

func getNoteName(midiNum: Int) -> String{
    switch midiNum {
    case 0:
        return "C"
    case 1:
        return "C#"
    case 2:
        return "D"
    case 3:
        return "D#"
    case 4:
        return "E"
    case 5:
        return "F"
    case 6:
        return "F#"
    case 7:
        return "G"
    case 8:
        return "G#"
    case 9:
        return "A"
    case 10:
        return "A#"
    case 11:
        return "B"
    default:
        return "?"
    }
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