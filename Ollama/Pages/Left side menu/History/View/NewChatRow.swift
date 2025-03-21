//
//  NewChatRow.swift
//  Ollama
//
//  Created by rbkusser on 20.03.2025.
//

import SwiftUI

struct NewChatRow: View {

    var didTap: () -> ()

    var body: some View {
        HStack {
            Label("New Chat", systemImage: "plus.rectangle.fill")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.black.opacity(0.9))
                .cornerRadius(12)
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .onTapGesture { didTap() }
    }
}

#Preview {
    NewChatRow(didTap: {})
}
