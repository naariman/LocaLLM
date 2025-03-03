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
    private var userDefaultsService = UserDefaultsService()

    private var urlString: String? = "http://localhost:11434/api/chat"
    private var requestData: ChatRequest?

    init() {
        requestData = ChatRequest(model: "llama3.1", messages: [])
    }

    func sendMessage() {
        Task { @MainActor in

            let userMessage = ChatMessage(role: .user, content: message)
            requestData?.messages.append(userMessage)
            message.removeAll()

            do {
                let response: ChatResponse = try await networkService.request(urlString: urlString, body: requestData, method: .POST)
                messages.append(ChatMessage(role: .assistant, content: response.message.content))
            } catch {
                print(error)
            }
        }
    }
}
