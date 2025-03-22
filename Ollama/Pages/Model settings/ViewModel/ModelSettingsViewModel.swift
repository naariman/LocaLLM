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

    var models: [ModelInformation] = []

    init() {
        urlString = userDefaultsService.getValue(for: .modelBaseUrl) ?? ""
        fetchModels()
    }
}

extension ModelSettingsViewModel {

    func fetchModels() {
        Task { @MainActor in
            state = .loading

            do {
                let requestUrl = urlString + Constants.tagsUrl
                let repsonse: ModelsList = try await networkService.request(urlString: requestUrl, method: .GET)
                models = repsonse.models
                state = .success(isModelsEmpty: repsonse.models.isEmpty)

                let savedModelName: String? = userDefaultsService.getValue(for: .modelName)
                selectedModel = models.first(where: { $0.name == savedModelName })
            } catch {
                state = .failure
            }
        }
    }

    func didTapSave(completion: () -> ()) {
        guard let name = selectedModel?.name else { return }
        userDefaultsService.set(value: name, for: .modelName)
        userDefaultsService.set(value: urlString, for: .modelBaseUrl)
        completion()
    }
}

