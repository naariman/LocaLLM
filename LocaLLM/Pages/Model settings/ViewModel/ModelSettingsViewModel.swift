//
//  ModelSettingsViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

class ModelSettingsViewModel: ObservableObject {

    enum State {
        case notEntered
        case loading
        case success(isModelsEmpty: Bool)
        case failure
    }

    @Published var state: State = .loading
    @Published var selectedModel: ModelInformation? = nil
    @Published var urlString: String

    private let userDefaultsService = UserDefaultsService()
    private let networkService = NetworkService()
    private let llmService = LLMService()

    var models: [ModelInformation] = []

    init() {
        urlString = userDefaultsService.getValue(for: .llmUrl) ?? ""
        fetchModels()
    }
}

extension ModelSettingsViewModel {

    func fetchModels() {
        Task { @MainActor in
            state = .loading

            do {
                let requestUrl = urlString + "/api/tags"
                let repsonse: ModelsList = try await networkService.request(urlString: requestUrl, method: .GET)
                models = repsonse.models
                state = .success(isModelsEmpty: repsonse.models.isEmpty)

                let savedModelName: String? = userDefaultsService.getValue(for: .llmName)
                selectedModel = models.first(where: { $0.name == savedModelName })
            } catch {
                state = .failure
            }
        }
    }

    func didTapSave(completion: () -> ()) {
        guard let name = selectedModel?.name else { return }
        llmService.save(modelName: name, baseUrl: urlString)
        completion()
    }
}

