//
//  UserDefaultsService.swift
//
//
//  Created by Daniel Yopla on 11.06.2024.
//

import Foundation

public final class UserDefaultsService {
    static let dateFormatter = ISO8601DateFormatter()

    public func getLastSynced() -> String? {
        UserDefaults.standard.string(forKey: "lastSynced")
    }

    public func setLastSynced(to date: Date?) {
        if let date {
            UserDefaults.standard.set(Self.dateFormatter.string(from: date), forKey: "lastSynced")
        } else {
            UserDefaults.standard.removeObject(forKey: "lastSynced")
        }
    }
}
