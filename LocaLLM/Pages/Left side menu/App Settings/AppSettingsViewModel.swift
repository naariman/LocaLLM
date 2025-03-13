//
//  AppSettingsViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 12.03.2025.
//

import SwiftUI

class AppSettingsViewModel: ObservableObject {

    @Published var selectedLanguage: Language = .english {
        didSet {

        }
    }

    @Published var selectedAppearance: Appearance = .light {
        didSet {

        }
    }

    func didSelect(language: Language) {}

    func didSelect(appearance: Appearance) {}

    func didTapClearChats() {}
}
