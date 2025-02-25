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

    @FocusState private var focusedField: FocusedField?

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ChatInputView(
                    text: $viewModel.message,
                    primaryButtonAction: {
                    },
                    expandButtonAction: {
                        showExapndedTextField.toggle()
                    }
                )
                .focused($focusedField, equals: .textField)
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
            .sheet(isPresented: $showExapndedTextField) {
                ExapndedTextField(text: $viewModel.message)
            }
            .onAppear {
                let name: String? = UserDefaultsStore().getValue(for: .llmSettingsName)
                let url: String? = UserDefaultsStore().getValue(for: .llmSettingsUrl)
                print("model name: \(String(describing: name))")
                print("model url: \(String(describing: url))")

                focusedField = .textField
            }
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

extension ChatView {

    enum FocusedField {
        case textField
    }
}

#Preview {
    ChatView()
}
