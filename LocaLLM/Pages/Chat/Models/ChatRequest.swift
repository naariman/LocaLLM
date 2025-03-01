//
//  ChatRequest.swift
//  LocaLLM
//
//  Created by rbkusser on 27.02.2025.
//

import Foundation

struct ChatRequest: Encodable {
    var model: String
    var messages: [ChatMessage]
    let stream: Bool = false
}
