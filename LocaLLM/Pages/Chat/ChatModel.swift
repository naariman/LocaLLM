//
//  ChatModel.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

struct ChatModel {

    var request: ChatModel.Request
    var response: ChatModel.Response?
}

extension ChatModel {

    struct Request: Encodable {
        var model: String
        var messages: [ChatModel.Message]
        let stream: Bool = false
    }

    struct Response: Decodable {
        let message: ChatModel.Message
    }
}

extension ChatModel {

    struct Message: Codable, Hashable {
        let role: ChatRole
        let content: String
    }

    enum ChatRole: String, Codable {
        case user
        case assistant
    }
}
