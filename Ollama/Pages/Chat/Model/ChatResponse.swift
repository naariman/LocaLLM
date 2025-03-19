//
//  ChatResponse.swift
//  LocaLLM
//
//  Created by rbkusser on 27.02.2025.
//

import Foundation

struct ChatResponse: Decodable {

    var created_at: Date
    let message: ChatMessage
}
