//
//  ChatViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

class ChatViewModel: ObservableObject {

    private var userDefaults = UserDefaultsStore()

    private var requestData: ChatRequest?
    private var urlString: String? = "http://localhost:11434/api/chat"

    @Published var message: String = ""
    @Published var messages: [ChatMessage] = []

    init() {
        guard
            let urlString: String = userDefaults.getValue(for: .llmUrl),
            let modelName: String = userDefaults.getValue(for: .llmName) else {
            return
        }

        requestData = ChatRequest(model: "llama3.1", messages: [])
    }

    func sendMessage() async {
        guard let urlString else { return }
        guard let url = URL(string: urlString) else {
            return
        }

        let newMessage = ChatMessage(role: .user, content: message)
        await MainActor.run {
            requestData?.messages.append(newMessage)
            messages.append(newMessage)
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encodedData = try? encoder.encode(requestData)
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
            let decodedData = try decoder.decode(ChatResponse.self, from: data)
            await MainActor.run {
                messages.append(decodedData.message)
                requestData?.messages.append(decodedData.message)
            }
        }
        catch(let error) {
            print(error.localizedDescription)
        }

    }
}
