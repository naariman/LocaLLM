//
//  ModelSettingsView.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import SwiftUI

struct ModelSettingsView: View {

    @ObservedObject var viewModel = ModelSettingsViewModel()

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading) {
            ModelSettingsHeaderView(
                closeButtonAction: {
                    viewModel.didTapSave { dismiss() }
                },
                retryFetchingButtonAction: { viewModel.fetchModels() }
            )
            .padding(.top, 24)

            ModelSettingsPrimaryTextField(
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
                ModelsInformationList(models: $viewModel.models, selectedModel: $viewModel.selectedModel)
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .onAppear { viewModel.fetchModels() }
    }
}

#Preview {
    ModelSettingsView()
}
