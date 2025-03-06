//
//  MessageRow.swift
//  LocaLLM
//
//  Created by rbkusser on 03.03.2025.
//

import SwiftUI

struct MessageRow: View {

    let message: ChatMessage

    var body: some View {
        switch message.role {
        case .user:
            HStack {
                Spacer()

                Text(message.content)
                    .padding(8)
                    .background(.lightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        case .assistant:
            Text(message.content)
        }
    }
}

#Preview("User") {
    MessageRow(
        message: ChatMessage(
            role: .user,
            content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        )
    )
}

#Preview("Assistant") {
    MessageRow(
        message: ChatMessage(
            role: .assistant,
            content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        )
    )
}
