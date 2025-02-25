//
//  ChatTextField.swift
//  LocaLLM
//
//  Created by rbkusser on 22.02.2025.
//

import SwiftUI

struct ChatTextField: View {

    @Binding var text: String
    var primaryButtonAction: () -> ()
    var expandButtonAction: () -> ()
    var isPrimaryButtonHidden: Bool = false

    var body: some View {
        VStack {
            TextField(text: $text, axis: .vertical) {
                Text(LocalizedStringKey("chat.messagePlaceholder"))
            }
            .padding(12)
            .lineLimit(3)

            supportView
        }
        .background(
            UnevenRoundedRectangle(
                cornerRadii: RectangleCornerRadii(
                    topLeading: 16,
                    topTrailing: 16
                )
            )
            .stroke(.secondary)
        )
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
    ChatTextField(
        text: .constant(""),
        primaryButtonAction: {},
        expandButtonAction: {}
    )
}
