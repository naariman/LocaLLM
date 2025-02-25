//
//  ChatTextField.swift
//  LocaLLM
//
//  Created by rbkusser on 22.02.2025.
//

import SwiftUI

struct ChatInputView: View {

    @Binding var text: String

    var primaryButtonAction: () -> ()
    var expandButtonAction: () -> ()
    var isPrimaryButtonHidden: Bool = false

    var body: some View {
        VStack {
            Divider()
            TextField(text: $text, axis: .vertical) {
                Text(LocalizedStringKey("chat.messagePlaceholder"))
            }
            .padding(8)
            .lineLimit(9)

            supportView
        }
        .overlay {

        }
    }

    private var supportView: some View {
        HStack {
            expandButton
            Spacer()
            primaryButton
        }
        .padding([.horizontal, .bottom], 8)
    }

    private var primaryButton: some View {
        Button {
            primaryButtonAction()
        } label: {
            Image(systemName: "arrow.up")
                .font(.system(size: 12, weight: .medium))
                .frame(width: 24, height: 24)
                .foregroundStyle(.white)
                .background(Circle().fill(.black))
        }
    }

    private var expandButton: some View {
        Button {
            expandButtonAction()
        } label: {
            Image(systemName: "arrow.up.left.and.arrow.down.right")
                .font(.system(size: 12, weight: .medium))
                .font(.system(size: 12))
                .frame(width: 24, height: 24)
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    ChatInputView(
        text: .constant(""),
        primaryButtonAction: {},
        expandButtonAction: {}
    )
}
