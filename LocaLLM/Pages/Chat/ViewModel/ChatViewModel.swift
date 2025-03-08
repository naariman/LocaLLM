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

    private var chatNetworkService = ChatNetworkService()
    private var llmService = LLMService()
    private var userDefaultsService = UserDefaultsService()

    private var urlString: String?
    private var requestData: ChatRequest

    init() {
        urlString = llmService.chatUrl
        requestData = ChatRequest(model: llmService.modelName ?? "", messages: [])
        chatNetworkService.delegate = self
    }

    func didTapSendMessage() {
        guard let urlString else { return }

        Task { @MainActor in
            let userMessage = ChatMessage(role: .user, content: message)
            requestData.messages.append(userMessage)
            messages.append(userMessage)

            message.removeAll()

            let assistantMessage = ChatMessage(role: .assistant, content: "")
            requestData.messages.append(assistantMessage)
            messages.append(assistantMessage)

            do {
                try await chatNetworkService.sendMessage(requestData: requestData, urlString: urlString)
            } catch {
                print("Error: \(error)")
            }
        }
    }
}

extension ChatViewModel: ChatNetworkServiceDelegate {

    func didAnswerWith(word: String) {
        DispatchQueue.main.async {
            self.messages[self.messages.count - 1].content += word
        }
    }
}
