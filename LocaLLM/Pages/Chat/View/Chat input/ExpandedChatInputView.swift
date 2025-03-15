//
//  ExpandedChatInputView.swift
//  LocaLLM
//
//  Created by rbkusser on 15.03.2025.
//

import SwiftUI

struct ExpandedChatInputView: View {

    @Binding var text: String

    var condenseButtonAction: () -> Void
    var sendMessageButtonAction: () -> Void
    var isRightButtonAvailable: Bool

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            ChatInputBar(
                leftButtonAction: condenseButtonAction,
                rightButtonAction: sendMessageButtonAction,
                leftButtonSystemName: "arrow.down.right.and.arrow.up.left",
                rightButtonSystemName: "paperplane.fill",
                isRightButtonAvailable: isRightButtonAvailable
            )
            .padding(.horizontal, 16)
            .padding(.vertical, 12)

            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text("Type a message...")
                        .foregroundColor(Color.gray.opacity(0.7))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                }

                TextEditor(text: $text)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .padding(.horizontal, 12)
                    .focused($isFocused)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .background(Color(UIColor.systemBackground))
        .onAppear { isFocused = true }
    }
}

#Preview {
    ExpandedChatInputView(
        text: .constant("This is a test message that spans multiple lines to demonstrate how the expanded input view works with longer content."),
        condenseButtonAction: {},
        sendMessageButtonAction: {},
        isRightButtonAvailable: true
    )
}
