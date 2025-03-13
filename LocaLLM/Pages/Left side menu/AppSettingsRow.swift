//
//  ProfileSettingsRow.swift
//  LocaLLM
//
//  Created by rbkusser on 12.03.2025.
//

import SwiftUI

struct AppSettingsRow: View {

    var body: some View {
        HStack {
            Image(systemName: "gearshape.fill")
                .font(.title3)
                .foregroundStyle(.secondary)

            Text(LocalizedStringKey("appSettings.title"))
                .font(.title3)
        }
    }
}

#Preview {
    AppSettingsRow()
}
