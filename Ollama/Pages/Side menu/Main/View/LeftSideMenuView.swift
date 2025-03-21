//
//  LeftSideMenuView.swift
//  LocaLLM
//
//  Created by rbkusser on 28.02.2025.
//

import SwiftUI

struct LeftSideMenuView: View {

    @StateObject private var viewModel = LeftSideMenuViewModel()
    @Binding var isShowing: Bool

    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { isShowing = false }

                HStack {
                    VStack {
                        HistoryList(chats: $viewModel.chats) { id in
                            viewModel.didSelectChat(with: id)
                        }
                        Spacer()
                        NewChatRow {
                            isShowing = false
                            viewModel.didTapNewChat()
                        }
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)

                    Spacer()
                }
            }
        }
    }
}

#Preview {
    LeftSideMenuView(isShowing: .constant(true))
}
