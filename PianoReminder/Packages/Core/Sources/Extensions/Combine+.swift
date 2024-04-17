//
//  Combine+.swift
//  
//
//  Created by Daniel Yopla on 05.07.2023.
//

import Combine

public extension PassthroughSubject where Output == Void {
    func sendAndComplete() {
        self.send()
        self.send(completion: .finished)
    }
}
