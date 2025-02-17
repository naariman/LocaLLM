//
//  LocaLLMApp.swift
//  LocaLLM
//
//  Created by rbkusser on 15.02.2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct LocaLLMApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @State private var showLaunchPage = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()

                if showLaunchPage {
                    LaunchPage(showLaunchPage: $showLaunchPage)
                }
            }
        }
    }
}
