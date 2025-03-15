//
//  LanguageSelectionRow.swift
//  LocaLLM
//
//  Created by rbkusser on 12.03.2025.
//

import SwiftUI

struct LanguageSelectionRow: View {

    @Binding var selectedLanguage: Language

    var body: some View {
        HStack {
            Image(systemName: "globe")
            Picker("App Language", selection: $selectedLanguage) {
                ForEach(Language.allCases, id: \.self) { language in
                    Text(language.displayName)
                }
            }
            .onTapGesture {
                let url = URL(string: UIApplication.openSettingsURLString)
                UIApplication.shared.open(url!)
            }
        }
    }
}

#Preview {
    LanguageSelectionRow(selectedLanguage: .constant(.english))
}
