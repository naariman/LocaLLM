//
//  LocaLLMApp.swift
//  LocaLLM
//
//  Created by rbkusser on 15.02.2025.
//

import SwiftUI

@main
struct LocaLLMApp: App {

    @StateObject private var commonStore = CommonStore()
    @State private var showLaunchPage = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                ChatView()
                    .environmentObject(commonStore)

                if showLaunchPage {
                    LaunchView(showLaunchPage: $showLaunchPage)
                }
            }
        }
    }
}
