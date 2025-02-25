//
//  LLMModelsResponse.swift
//  LocaLLM
//
//  Created by rbkusser on 19.02.2025.
//

import Foundation

struct LLMModelsResponse: Decodable {
    let models: [LLMModel]
}

struct LLMModel: Decodable, Hashable, Identifiable {

    var id: UUID
    var name: String
    var size: Int

    enum CodingKeys: CodingKey {
        case name
        case size
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.size = try container.decode(Int.self, forKey: .size)
    }

    init(name: String, size: Int) {
        self.id = UUID()
        self.name = name
        self.size = size
    }
}

