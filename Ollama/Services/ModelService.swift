//
//  LLMService.swift
//  LocaLLM
//
//  Created by rbkusser on 26.02.2025.
//

import Foundation

struct ModelService {

    private var userDefaultsService = UserDefaultsService()

    var chatUrl: String? {
        guard let baseUrl: String = userDefaultsService.getValue(for: .llmUrl) else { return nil }
        return baseUrl + "/api/chat"
    }

    var modelName: String? {
        guard let name: String = userDefaultsService.getValue(for: .llmName) else { return nil }
        return name
    }

    func save(modelName: String, baseUrl: String) {
        var urlToSave = baseUrl

        if baseUrl.last == "/" { urlToSave.removeLast() }

        userDefaultsService.set(value: urlToSave, for: .llmUrl)
        userDefaultsService.set(value: modelName, for: .llmName)
    }
}
