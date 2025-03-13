//
//  CommonStore.swift
//  LocaLLM
//
//  Created by rbkusser on 20.02.2025.
//

import Foundation

class CommonStore: ObservableObject {

//    var LLMSettings: LLMSettingsModel? = nil

    private var userDefaults: UserDefaultsService

    init() {
        userDefaults = UserDefaultsService()
    }

    var number = 1

    var languageKey: String {
        get {
            userDefaults.getValue(for: .language) ?? Locale.current.identifier
        }
    }
}
