//
//  Language.swift
//  LocaLLM
//
//  Created by rbkusser on 12.03.2025.
//

import Foundation

enum Language: String, CaseIterable {

    case english
    case russian

    var key: String {
        switch self {
        case .english: return "en"
        case .russian: return "ru"
        }
    }

    var displayName: String {
        switch self {
        case .english: return "English"
        case .russian: return "Русский"
        }
    }
}
