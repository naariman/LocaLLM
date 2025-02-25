//
//  ChatView.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import SwiftUI

struct ChatView: View {

    @StateObject var viewModel = ChatViewModel()

    @State private var showLLMSettingsView = false
    @State private var showRightSideMenu = false
    @State private var showExapndedTextField = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ChatTextField(text: $viewModel.message, primaryButtonAction: {}, expandButtonAction: {})
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        
                    }
                    label: {
                        Image(systemName: "line.3.horizontal")
                            .tint(.black)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showLLMSettingsView.toggle()
                    }
                    label: {
                        Image(systemName: "globe")
                            .tint(.black)
                    }
                }
            }
            .sheet(isPresented: $showLLMSettingsView) {
                LLMSettingsView()
            }
            .onAppear {
                let name: String? = UserDefaultsStore().getValue(for: .llmSettingsName)
                let url: String? = UserDefaultsStore().getValue(for: .llmSettingsUrl)
                print("model name: \(String(describing: name))")
                print("model url: \(String(describing: url))")
            }
        }
    }
}

#Preview {
    ChatView()
}
