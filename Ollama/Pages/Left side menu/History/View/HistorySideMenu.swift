//
//  HistorySideMenu.swift
//  LocaLLM
//
//  Created by rbkusser on 28.02.2025.
//

import SwiftUI

struct HistorySideMenu: View {

    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel = HistorySideMenuViewModel()

    @Binding var isShowing: Bool

    @State private var showProfileSettings = false

    var body: some View {
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture { isShowing = false }

                HStack {
                    VStack {

                        NewChatRow()
                            .onTapGesture { viewModel.didTapNewChat() }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 270, alignment: .leading)
                    .background(.white)

                    Spacer()
                }
            }
        }
        .transition(.move(edge: .leading))
        .animation(.easeInOut, value: isShowing)
    }
}

#Preview {
    HistorySideMenu(isShowing: .constant(true))
}
