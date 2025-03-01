//
//  LLMSettingsView.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import SwiftUI

struct LLMSettingsView: View {

    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: LLMSettingsViewModel

    init() {
        viewModel = LLMSettingsViewModel()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            LLMSettingsHeaderView(
                title: LocalizedStringKey("llmSettings.title"),
                subtitle: LocalizedStringKey("llmSettings.subtitle"),
                closeButtonAction: {
                    viewModel.didTapSave {
                        dismiss()
                    }
                }
            )

            LLMSettingsTextField(
                placeholder: LocalizedStringKey("llmSettings.urlPlaceholder"),
                text: $viewModel.urlString,
                state: $viewModel.state,
                onChange: viewModel.fetchModels
            )

            if case .success(isModelsEmpty: true) = viewModel.state {
                EmptyView(
                    image: Image(systemName: "tray.fill"),
                    title: LocalizedStringKey("llmSettings.empty.title"),
                    subtitle: LocalizedStringKey("llmSettings.empty.subtitle")
                )
            }

            if case .success(isModelsEmpty: false) = viewModel.state {
                LLMSettingsModelsList(models: $viewModel.models, selectedModel: $viewModel.selectedModel)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
    }
}

#Preview {
    LLMSettingsView()
}
