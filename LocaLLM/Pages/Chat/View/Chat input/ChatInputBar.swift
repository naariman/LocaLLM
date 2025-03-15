//
//  ChatInputBar.swift
//  LocaLLM
//
//  Created by rbkusser on 15.03.2025.
//

import SwiftUI

struct ChatInputBar: View {

    var leftButtonAction: () -> Void
    var rightButtonAction: () -> Void

    var leftButtonSystemName: String
    var rightButtonSystemName: String

    var isRightButtonAvailable: Bool

    var body: some View {
        HStack {
            Button {
                leftButtonAction()
            } label: {
                Image(systemName: leftButtonSystemName)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.gray)
            }

            Spacer()

            Button {
                if isRightButtonAvailable {
                    rightButtonAction()
                }
            } label: {
                Image(systemName: rightButtonSystemName)
                    .font(.system(size: 16, weight: .medium))
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.white)
                    .background(Circle().fill(.black))
                    .opacity( isRightButtonAvailable ? 1 : 0.3)
            }
        }
    }
}

#Preview {
    ChatInputBar(
        leftButtonAction: {},
        rightButtonAction: {},
        leftButtonSystemName: "arrow.up",
        rightButtonSystemName: "arrow.up.left.and.arrow.down.right",
        isRightButtonAvailable: true
    )
}
