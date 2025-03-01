//
//  LlmUrlManager.swift
//  LocaLLM
//
//  Created by rbkusser on 26.02.2025.
//

import Foundation

struct LLMManager {

    private var userDefaults = UserDefaultsStore()

    var baseUrl: String? {
        get {
            userDefaults.getValue(for: .llmUrl)
        }
        set {
            userDefaults.set(value: newValue, for: .llmUrl)
        }
    }

    var modelName: String? {
        get {
            userDefaults.getValue(for: .llmName)
        }
        set {
            userDefaults.set(value: newValue, for: .llmName)
        }
    }

    var chatUrl: String? {
        guard let baseUrl else { return nil }

        return baseUrl + "/chat"
    }

    func isConnected() async -> Bool {
        guard let baseUrl else { return false }

        let urlString = baseUrl + "/tags"
        guard let url = URL(string: urlString) else { return false }

        let request = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return false
            }
            return true
        }
        catch {
            return false
        }
    }
}
