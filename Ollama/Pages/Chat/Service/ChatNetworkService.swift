//
//  ChatNetworkService.swift
//  LocaLLM
//
//  Created by rbkusser on 08.03.2025.
//

import Foundation

protocol ChatNetworkServiceDelegate {

    func didAnswerWith(word: String, done: Bool)
    func didMake(title: String)
}

struct ChatNetworkService {

    private var networkService = NetworkService()
    var delegate: ChatNetworkServiceDelegate?

    func sendMessage(requestData: ChatRequest, urlString: String) async throws {
        guard let url = URL(string: urlString) else {
            NetworkLogger.log(error: NetworkError.urlError)
            throw NetworkError.urlError
        }

        var request = URLRequest(url: url)
        request.httpMethod = NetworkMethod.POST.rawValue
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(requestData)
        } catch {
            NetworkLogger.log(error: NetworkError.encodingError)
            throw NetworkError.encodingError
        }

        NetworkLogger.log(request: request)

        do {
            let (stream, urlResponse) = try await URLSession.shared.bytes(for: request)

            guard let httpResponse = urlResponse as? HTTPURLResponse else {
                let error = NetworkError.unknown(message: "Invalid response type")
                NetworkLogger.log(error: error)
                throw error
            }

            NetworkLogger.log(response: httpResponse, data: nil)

            if let error = NetworkError.error(from: httpResponse.statusCode) {
                NetworkLogger.log(error: error)
                throw error
            }

            for try await line in stream.lines {
                if let data = line.data(using: .utf8),
                   let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let message = json["message"] as? [String: Any],
                   let content = message["content"] as? String,
                   let done = json["done"] as? Bool {

                    if let lineData = line.data(using: .utf8) {
                        NetworkLogger.log(response: httpResponse, data: lineData)
                    }

                    delegate?.didAnswerWith(word: content, done: done)
                }
            }
        }
        catch let networkError as NetworkError {
            NetworkLogger.log(error: networkError)
            throw networkError
        }
        catch {
            let wrappedError = NetworkError.unknown(message: error.localizedDescription)
            NetworkLogger.log(error: wrappedError)
            throw wrappedError
        }
    }

    func title(requestData: ChatRequest, urlString: String) async throws {
        var requestData = ChatRequest(
            model: requestData.model,
            messages: requestData.messages,
            stream: false
        )

        let promptToGetTitle = ChatMessage(
            role: .user,
            content: "Make a conversation title in 2-3 words. Important answer only on 2-3 words!"
        )

        requestData.messages.append(promptToGetTitle)

        do {
            let response: ChatResponse = try await networkService.request(
                urlString: urlString,
                body: requestData,
                method: .POST
            )

            delegate?.didMake(title: response.message.content)
        } catch {
            NetworkLogger.log(error: error)
            print("Error: \(error)")
        }
    }
}
