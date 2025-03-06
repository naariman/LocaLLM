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
                    List{
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
                    primaryButtonAction: {
                        viewModel.sendMessage()
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
                        showRightSideMenu.toggle()
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
