//
//  LLMSettingsHeaderView.swift
//  LocaLLM
//
//  Created by rbkusser on 24.02.2025.
//

import SwiftUI

struct LLMSettingsHeaderView: View {

    var closeButtonAction: () -> Void
    var retryFetchingButtonAction: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button("Retry", action: retryFetchingButtonAction)

                Spacer()

                Button("Save", action: closeButtonAction)
            }
            .overlay {
                Text("Model settings")
                    .font(.headline)
            }
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}
