//
//  ChatView.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import SwiftUI

struct ChatView: View {

    enum FocusedField {
        case textField
    }

    @StateObject var viewModel = ChatViewModel()

    @State private var showLLMSettingsView = false
    @State private var showHistorySideMenu = false
    @State private var showExapndedTextField = false

    @FocusState private var focusedField: FocusedField?

    var body: some View {
        HStack {
            if showHistorySideMenu {
                HistorySideMenu()
                    .frame(width: 260)
                    .transition(.move(edge: .leading))
            }

            NavigationStack {
                VStack {
                    ScrollViewReader { proxy in
                        List {
                            ForEach(viewModel.messages, id: \.self) { message in
                                MessageRow(message: message)
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(
                                        EdgeInsets(
                                            top: viewModel.messages.first == message ? 0 : 16,
                                            leading: 0,
                                            bottom: message.role == .user ? 4 : 0,
                                            trailing: 0
                                        )
                                    )
                                    .id(message.id)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .onChange(of: viewModel.messages) {
                            withAnimation {
                                proxy.scrollTo(viewModel.messages.last?.id)
                            }
                        }
                    }

                    Spacer()

                    ChatInputView(
                        text: $viewModel.message,
                        sendMessageButtonAction: { didTapSendMessageButton() },
                        expandButtonAction: { showExapndedTextField = true },
                        isRightButtonAvailable: !viewModel.message.isEmpty
                    )
                    .focused($focusedField, equals: .textField)
                }
                .onTapGesture {
                    focusedField = nil
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            withAnimation { showHistorySideMenu = true }
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
                .sheet(isPresented: $showLLMSettingsView) { ModelSettingsView() }
                .sheet(isPresented: $showExapndedTextField) {
                    ExpandedChatInputView(
                        text: $viewModel.message,
                        condenseButtonAction: { showExapndedTextField = false },
                        sendMessageButtonAction: { didTapSendMessageButton() },
                        isRightButtonAvailable: !viewModel.message.isEmpty
                    )
                }
                .onAppear { focusedField = .textField }
            }
        }
    }
}

private extension ChatView {

    func didTapSendMessageButton() {
        showExapndedTextField = false
        viewModel.didTapSendMessage()
    }
}

#Preview {
    ChatView()
}
