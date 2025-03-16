//
//  ChatMessage.swift
//  LocaLLM
//
//  Created by rbkusser on 27.02.2025.
//

import Foundation

struct ChatMessage: Codable, Hashable {

    var id = UUID()
    let role: ChatRole
    var content: String


    enum CodingKeys: String, CodingKey {
        case role, content
    }
}
