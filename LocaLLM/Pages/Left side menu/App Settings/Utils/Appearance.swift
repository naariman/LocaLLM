//
//  Appearance.swift
//  LocaLLM
//
//  Created by rbkusser on 12.03.2025.
//

import SwiftUICore

enum Appearance: String, CaseIterable {

    case light
    case dark

    var displayName: LocalizedStringKey {
        switch self {
        case .light: return LocalizedStringKey("appSettings.appearance.light")
        case .dark: return LocalizedStringKey("appSettings.appearance.dark")
        }
    }
}
