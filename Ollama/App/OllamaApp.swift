//
//  OllamaApp.swift
//  LocaLLM
//
//  Created by rbkusser on 15.02.2025.
//

import SwiftUI
import SwiftData

@main
struct OllamaApp: App {

    var body: some Scene {
        WindowGroup {
            ChatView()
        }
        .modelContainer(for: ChatsLocalStorageModel.self)
    }
}
