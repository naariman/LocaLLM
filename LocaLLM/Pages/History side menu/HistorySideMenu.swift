//
//  HistorySideMenu.swift
//  LocaLLM
//
//  Created by rbkusser on 28.02.2025.
//

import SwiftUI

struct HistorySideMenu: View {

    @Binding var isShowing: Bool
    var edgeTransition: AnyTransition = .move(edge: .leading)

    var body: some View {
        ZStack {
            Color.white

            Form {
                Text("some text")
                Text("some text")
                Text("some text")
                Text("some text")
            }
        }
        .transition(edgeTransition)
        .animation(.easeInOut, value: isShowing)
        .scrollContentBackground(.hidden)
    }
}
