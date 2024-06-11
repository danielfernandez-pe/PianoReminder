//
//  EntityToSyncDTO.swift
//
//
//  Created by Daniel Yopla on 11.06.2024.
//

import Foundation

struct EntityToSyncDTO: Decodable {
    enum SyncType: String, Decodable {
        case created
        case updated
        case deleted
    }

    let id: String
    let syncType: SyncType
    let modified: String
    let locale: String
}
