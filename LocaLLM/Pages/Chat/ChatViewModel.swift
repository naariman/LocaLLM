//
//  ChatViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

class ChatViewModel: ObservableObject {

    private var userDefaults = UserDefaultsStore()

    @Published var chatModel: ChatModel?

    @Published var text: String = ""

    var urlString: String?

    @Published var message: String = ""

    init() {
        guard
            let urlString: String = userDefaults.getValue(for: .llmSettingsUrl),
            let modelName: String = userDefaults.getValue(for: .llmSettingsName) else {
            return
        }

        chatModel = ChatModel(request: ChatModel.Request(model: "llama3.1", messages: []))
        self.urlString = "http://localhost:11434/api/chat"
    }

    func messages() -> [ChatModel.Message] {
        chatModel?.request.messages ?? []
    }

    func sendMessage() async {
        guard let urlString else { return }
        guard let url = URL(string: urlString) else {
            return
        }

        let newMessage = ChatModel.Message(role: .user, content: message)
        await MainActor.run {
            chatModel?.request.messages.append(newMessage)
        }

        let requestObject = ChatModel.Request(
            model: chatModel!.request.model,
            messages: chatModel!.request.messages
        )

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encodedData = try? encoder.encode(requestObject)
        request.httpBody = encodedData

        if let encodedData = encodedData,
           let jsonString = String(data: encodedData, encoding: .utf8) {
            print("JSON being sent:")
            print(jsonString)
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }

            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(ChatModel.Response.self, from: data)
            await MainActor.run {
                chatModel?.request.messages.append(decodedData.message)
            }
        }
        catch(let error) {
            print(error.localizedDescription)
        }

    }
}
