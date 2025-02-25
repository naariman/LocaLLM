//
//  LLMSettings.swift
//  LocaLLM
//
//  Created by rbkusser on 20.02.2025.
//

import SwiftData

@Model
class LLMSettings {

    var url: String
    var name: String

    init(url: String, name: String) {
        self.url = url
        self.name = name
    }
}
