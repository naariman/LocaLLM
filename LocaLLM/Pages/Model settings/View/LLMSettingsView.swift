//
//  LLMSettingsView.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import SwiftUI

struct LLMSettingsView: View {

    @ObservedObject var viewModel = LLMSettingsViewModel()

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            LLMSettingsHeaderView(
                closeButtonAction: {
                    viewModel.didTapSave { dismiss() }
                },
                retryFetchingButtonAction: { viewModel.fetchModels() }
            )
            .padding(.top, 8)

            LLMSettingsTextField(
                text: $viewModel.urlString,
                state: $viewModel.state,
                onChange: viewModel.fetchModels
            )
            .padding(.top, 32)

            if case .success(isModelsEmpty: true) = viewModel.state {
                EmptyView(
                    image: Image(systemName: "tray.fill"),
                    title: "No Models Available",
                    subtitle: "It looks like there are no models to display. Please add a new model on your server and reenter URL."
                )
            }

            if case .success(isModelsEmpty: false) = viewModel.state {
                LLMSettingsModelsList(models: $viewModel.models, selectedModel: $viewModel.selectedModel)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
        .onAppear { viewModel.fetchModels() }
    }
}

#Preview {
    LLMSettingsView()
}
