//
//  Question.swift
//  
//
//  Created by Daniel Yopla on 06.06.2023.
//

import SwiftUI

public struct Question {
    var options: [UserOption]
    var musicView: MusicView

    public init(options: [UserOption], musicView: MusicView) {
        self.options = options
        self.musicView = musicView
    }
}
