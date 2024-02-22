//
//  BassNotePositioner.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation

// swiftlint:disable cyclomatic_complexity
struct BassNotePositioner {
    func yPosition(for note: NoteUI, in octave: OctaveUI) -> CGFloat {
        switch note {
        case .c:
            switch octave {
            case .oct1:
                return Constants.spaceToMoveOneNote * 15
            case .oct2:
                return Constants.spaceToMoveOneNote * 8
            case .oct3:
                return Constants.spaceToMoveOneNote * 1
            case .middleC:
                return Constants.spaceToMoveOneNote * -6
            case .oct5:
                return Constants.spaceToMoveOneNote * -13
            case .oct6:
                return Constants.spaceToMoveOneNote * -19
            case .oct7:
                return Constants.spaceToMoveOneNote * -26
            }
        case .d:
            return yPosition(for: .c, in: octave) - Constants.spaceToMoveOneNote
        case .e:
            return yPosition(for: .c, in: octave) - Constants.spaceToMoveOneNote * 2
        case .f:
            return yPosition(for: .c, in: octave) - Constants.spaceToMoveOneNote * 3
        case .g:
            return yPosition(for: .c, in: octave) - Constants.spaceToMoveOneNote * 4
        case .a:
            return yPosition(for: .c, in: octave) - Constants.spaceToMoveOneNote * 5
        case .b:
            return yPosition(for: .c, in: octave) - Constants.spaceToMoveOneNote * 6
        }
    }
}
// swiftlint:enable cyclomatic_complexity
