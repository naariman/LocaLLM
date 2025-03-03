//
//  HistorySideMenu.swift
//  LocaLLM
//
//  Created by rbkusser on 28.02.2025.
//

import SwiftUI

struct HistorySideMenu: View {

    @Binding var isShowing: Bool

    var body: some View {
        ZStack {

            if isShowing {
                Color.black
                    .opacity(0.3)
                    .onTapGesture { isShowing.toggle() }
            }

            Form {
                Text("some text")
                Text("some text")
                Text("some text")
                Text("some text")
            }
            .transition(AnyTransition(.move(edge: .leading)))
            .animation(.easeInOut, value: isShowing)
        }
    }
}
