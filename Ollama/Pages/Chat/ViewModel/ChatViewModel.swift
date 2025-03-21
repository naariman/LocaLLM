//
//  ChatViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import SwiftUI

class ChatViewModel: ObservableObject {

    @Environment(\.modelContext) var modelContext

    @Published var message: String = ""
    @Published var messages: [ChatMessage] = []

    private var urlString: String?
    private var requestData: ChatRequest

    private var chatNetworkService = ChatNetworkService()
    private let notifiacationService = BaseNotificationManager()
    private var modelSettings = ModelService()

    init() {
        urlString = modelSettings.chatUrl
        requestData = ChatRequest(model: modelSettings.modelName ?? "", messages: [], stream: true)
        notifiacationService.subscribe(to: .didTapNewChat)
        notifiacationService.subscribe(to: .didSelectChat)
        notifiacationService.delegate = self
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

    func didAnswerWith(word: String, done: Bool) {
        Task { @MainActor in
            self.messages[self.messages.count - 1].content += word
        }

        if messages.count > 3 {
            if done {
                Task {
                    do {
                        try await chatNetworkService.title(
                            requestData: requestData,
                            urlString: urlString ?? ""
                        )
                    } catch {
                        print("Failed to get title: \(error)")
                    }
                }
            }
        }
    }

    func didMake(title: String) {
        
    }
}

extension ChatViewModel: BaseNotificationManagerDelegate {

    func performOnTrigger(_ notification: BaseNotification, object: Any?, userInfo: [AnyHashable : Any]?) {
        switch notification {
        case .didTapNewChat:
            didTapNewChat()
        case .didSelectChat:
            guard let id = object as? String else { return }
            didSelectChat(with: id)
            didTapNewChat()
        default: break
        }
    }

    private func didTapNewChat() {
        requestData.messages.removeAll()
        messages.removeAll()
    }

    private func didSelectChat(with id: String) {

    }
}
