//
//  UserDefaultsService.swift
//  LocaLLM
//
//  Created by rbkusser on 20.02.2025.
//

import Foundation

class UserDefaultsService {

    enum Key: String {

        case llmUrl
        case llmName
    }

    private let userDefaults = UserDefaults()

    func getValue<T>(for key: Key) -> T? {
        userDefaults.value(forKey: key.rawValue) as? T
    }

    func set<T>(value: T, for key: Key) {
        userDefaults.set(value, forKey: key.rawValue)
    }

    func removeValue(for key: Key) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
