//
//  LLMSettingsViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation
import SwiftUICore

class LLMSettingsViewModel: ObservableObject {

    enum State {
        case notEntered
        case loading
        case success(isModelsEmpty: Bool)
        case failure
    }

    private let userDefaultsStore = UserDefaultsStore()

    @Published var state: State
    @Published var selectedModel: LLMModel?
    @Published var urlString: String

    var models: [LLMModel]

    init() {
        self.urlString = userDefaultsStore.getValue(for: .llmSettingsUrl) ?? ""
        self.selectedModel = nil
        self.state = .notEntered
        self.models = []
    }
}

extension LLMSettingsViewModel {

    func fetchModels() {
        Task {
            let (state, response) = await processFetchModels(urlString: urlString)
            await MainActor.run {
                self.state = state
                if let models = response?.models {
                    self.models = models

                    let savedModelName: String? = userDefaultsStore.getValue(for: .llmSettingsName)
                    selectedModel = models.first(where: { $0.name == savedModelName })
                }
            }
        }
    }

    private func processFetchModels(urlString: String) async -> (state: State, response: LLMModelsResponse?) {
        guard let url = URL(string: urlString) else {
            return (State.failure, nil)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return (State.failure, nil)
            }

            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(LLMModelsResponse.self, from: data)

            return (State.success(isModelsEmpty: decodedResponse.models.isEmpty), decodedResponse)
        }
        catch {
            return (State.failure, nil)
        }
    }

    func didTapSave(completion: () -> ()) {
        userDefaultsStore.set(value: urlString, for: .llmSettingsUrl)
        userDefaultsStore.set(value: selectedModel?.name ?? "", for: .llmSettingsName)
        completion()
    }
}

