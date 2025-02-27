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

                ScrollViewReader { proxy in

                    if let messages = viewModel.chatModel?.request.messages {
                        List{
                            ForEach(messages, id: \.self) { message in
                                if message.role == .user {
                                    UserMessageRow(message: message)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 4, trailing: 0))
                                }
                                else {
                                    AssistantMessageRow(message: message)
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .onChange(of: viewModel.chatModel?.request.messages) {
                            withAnimation {
                                proxy.scrollTo(viewModel.chatModel?.request.messages.last)
                            }
                        }
                    }

                }

                Spacer()

                ChatInputView(
                    text: $viewModel.message,
                    primaryButtonAction: {
                        Task {
                            await viewModel.sendMessage()
                        }
                    },
                    expandButtonAction: {
                        showExapndedTextField.toggle()
                    }
                )
                .focused($focusedField, equals: .textField)
            }
            .onTapGesture {
                focusedField = nil
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
                focusedField = .textField
            }
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
