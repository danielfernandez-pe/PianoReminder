//
//  UserDefaultsService.swift
//
//
//  Created by Daniel Yopla on 11.06.2024.
//

import Foundation

public final class UserDefaultsService {
    static let dateFormatter = ISO8601DateFormatter()

    public var lastSynced: Date? {
        get {
            guard let dateString = UserDefaults.standard.string(forKey: "lastSynced") else { return nil }
            return Self.dateFormatter.date(from: dateString)
        }
        set {
            if let newValue {
                UserDefaults.standard.set(Self.dateFormatter.string(from: newValue), forKey: "lastSynced")
            } else {
                UserDefaults.standard.removeObject(forKey: "lastSynced")
            }
        }
    }
}
