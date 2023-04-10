//
//  BassNotePositioner.swift
//  
//
//  Created by Daniel Yopla on 10.04.2023.
//

import Foundation

struct BassNotePositioner {
    private var spaceToMoveOneNote: CGFloat {
        (Constants.spaceBetweenBars + Constants.barHeight) / 2
    }

    func yPosition(for note: Note, in octave: Octave) -> CGFloat {
        switch note {
        case .c:
            switch octave {
            case .oct1:
                return spaceToMoveOneNote * 15
            case .oct2:
                return spaceToMoveOneNote * 8
            case .oct3:
                return spaceToMoveOneNote * 1
            case .middleC:
                return spaceToMoveOneNote * -6
            case .oct5:
                return spaceToMoveOneNote * -13
            case .oct6:
                return spaceToMoveOneNote * -19
            case .oct7:
                return spaceToMoveOneNote * -26
            }
        case .d:
            return yPosition(for: .c, in: octave) - spaceToMoveOneNote
        case .e:
            return yPosition(for: .c, in: octave) - spaceToMoveOneNote * 2
        case .f:
            return yPosition(for: .c, in: octave) - spaceToMoveOneNote * 3
        case .g:
            return yPosition(for: .c, in: octave) - spaceToMoveOneNote * 4
        case .a:
            return yPosition(for: .c, in: octave) - spaceToMoveOneNote * 5
        case .b:
            return yPosition(for: .c, in: octave) - spaceToMoveOneNote * 6
        }
    }
}
