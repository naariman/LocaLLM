//
//  ChatNetworkService.swift
//  LocaLLM
//
//  Created by rbkusser on 08.03.2025.
//

import Foundation

protocol ChatNetworkServiceDelegate {

    func didAnswerWith(word: String)
    func didMake(title: String)
}

struct ChatNetworkService {

    var delegate: ChatNetworkServiceDelegate?

    func sendMessage(requestData: ChatRequest, urlString: String) async throws(NetworkError) {
        guard let url = URL(string: urlString) else { throw .urlError }

        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethod.POST.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(requestData)
        } catch {
            throw NetworkError.encodingError
        }

        do {
            let (stream, urlResponse) = try await URLSession.shared.bytes(for: request)

            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                throw NetworkError.unknown(message: "Cast error 'urlResponse as? HTTPURLResponse'")
            }

            if let error = NetworkError.error(by: urlResponse.statusCode) { throw error }

            for try await line in stream.lines {
                if let data = line.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let message = json["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    delegate?.didAnswerWith(word: content)
                }
            }
        }
        catch let networkError as NetworkError { throw networkError }
        catch { throw NetworkError.unknown(message: error.localizedDescription) }
    }

    func title(requestData: ChatRequest, urlString: String) async throws(NetworkError) {
        let userMessages = requestData.messages.filter({ $0.role == .user })
        let requestData = ChatRequest(model: requestData.model, messages: userMessages, stream: false)
        let promptToGetTitle = "Make conversation conclusion in 2-3 words"
    }
}
