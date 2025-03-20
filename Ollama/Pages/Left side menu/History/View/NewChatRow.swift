//
//  NewChatRow.swift
//  Ollama
//
//  Created by rbkusser on 20.03.2025.
//

import SwiftUI

struct NewChatRow: View {

    var body: some View {
        HStack {
            Image(systemName: "plus.rectangle.fill")
            Text("New Chat")
        }
    }
}

#Preview {
    NewChatRow()
}
