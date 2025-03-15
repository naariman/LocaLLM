//
//  AppearanceSelectionRow.swift
//  LocaLLM
//
//  Created by rbkusser on 12.03.2025.
//

import SwiftUI

struct AppearanceSelectionRow: View {

    @Binding var selectedAppearance: Appearance

    var body: some View {
        HStack {
            Image(systemName: "sun.min")
            Picker("Color Scheme", selection: $selectedAppearance) {
                ForEach(Appearance.allCases, id: \.self) { appearance in
                    Text(appearance.displayName)
                }
            }
        }
    }
}
