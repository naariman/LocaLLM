//
//  OllamaApp.swift
//  LocaLLM
//
//  Created by rbkusser on 15.02.2025.
//

import SwiftUI

@main
struct OllamaApp: App {

    @State private var showLaunchPage = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                ChatView()

                if showLaunchPage {
                    LaunchView(showLaunchPage: $showLaunchPage)
                }
            }
        }
    }
}
