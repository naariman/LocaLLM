//
//  ChatViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

class ChatViewModel: ObservableObject {

    @Published var message: String = ""
    @Published var messages: [ChatMessage] = []

    private var networkService = NetworkService()
    private var llmService = LLMService()
    private var userDefaultsService = UserDefaultsService()

    private var urlString: String?
    private var requestData: ChatRequest?

    init() {
        urlString = llmService.chatUrl
        requestData = ChatRequest(model: llmService.modelName ?? "", messages: [])
    }

    func sendMessage() {
        Task { @MainActor in

            let userMessage = ChatMessage(role: .user, content: message)
            messages.append(userMessage)
            requestData?.messages.append(userMessage)
            message.removeAll()

            do {
                let response: ChatResponse = try await networkService.request(urlString: urlString, body: requestData, method: .POST)
                messages.append(response.message)
            } catch {
                print(error)
            }
        }
    }
}
