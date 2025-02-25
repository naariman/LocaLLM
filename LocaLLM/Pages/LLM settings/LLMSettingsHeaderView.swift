//
//  LLMSettingsHeaderView.swift
//  LocaLLM
//
//  Created by rbkusser on 24.02.2025.
//

import SwiftUI

struct LLMSettingsHeaderView: View {

    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    var closeButtonAction: () -> ()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(LocalizedStringKey("llmSettings.title"))
                    .font(.largeTitle)

                Spacer()

                Button {
                    closeButtonAction()
                } label: {
                    Image(systemName: "xmark")
                        .tint(.black)
                        .padding(8)
                }
            }

            Text(LocalizedStringKey("llmSettings.subtitle"))
                .font(.subheadline)
                .foregroundStyle(.secondary.opacity(0.6))
                .padding(.bottom, 4)
        }
    }
}

#Preview {
    LLMSettingsHeaderView(
        title: LocalizedStringKey("example"),
        subtitle: LocalizedStringKey("exmaple"),
        closeButtonAction: {}
    )
}
