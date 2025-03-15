//
//  ChatInputView.swift
//  LocaLLM
//
//  Created by rbkusser on 15.03.2025.
//

import SwiftUI

struct ChatInputView: View {

    @Binding var text: String

    var sendMessageButtonAction: () -> Void
    var expandButtonAction: () -> Void
    var isRightButtonAvailable: Bool

    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: -2)

            TextField("Type a message...", text: $text, axis: .vertical)
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
                .lineLimit(1...9)

            ChatInputBar(
                leftButtonAction: expandButtonAction,
                rightButtonAction: sendMessageButtonAction,
                leftButtonSystemName: "arrow.up.left.and.arrow.down.right",
                rightButtonSystemName: "paperplane.fill",
                isRightButtonAvailable: true
            )
            .padding(8)
        }
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    VStack {
        Spacer()
        ChatInputView(
            text: .constant("Hello world"),
            sendMessageButtonAction: {},
            expandButtonAction: {},
            isRightButtonAvailable: true
        )
    }
}
