//
//  ChatModel.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

struct ChatModel {

    var request: ChatModel.Request
    var response: ChatModel.Response
}

extension ChatModel {

    struct Request {
        let model: String
        let messages: [ChatModel.Message]
        let stream: Bool = false
    }

    struct Response {
        let message: ChatModel.Message
    }
}

extension ChatModel {

    struct Message {
        let role: ChatRole
        let content: String

    }

    enum ChatRole: String {
        case user
        case assistant
    }
}
