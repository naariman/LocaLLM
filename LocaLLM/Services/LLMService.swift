//
//  LLMService.swift
//  LocaLLM
//
//  Created by rbkusser on 26.02.2025.
//

import Foundation

struct LLMService {

    private var userDefaultsService = UserDefaultsService()

    var chatUrl: String? {
        guard let baseUrl: String = userDefaultsService.getValue(for: .llmUrl) else { return nil }
        return baseUrl + "/chat"
    }

    func save(modelName: String, baseUrl: String) {
        var urlToSave = baseUrl
        var modelNameToSave = modelName

        if baseUrl.last == "/" { urlToSave.removeLast() }

        userDefaultsService.set(value: urlToSave, for: .llmUrl)
        userDefaultsService.set(value: modelNameToSave, for: .llmName)
    }
}
