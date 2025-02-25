//
//  ExapndedTextField.swift
//  LocaLLM
//
//  Created by rbkusser on 25.02.2025.
//

import SwiftUI

struct ExapndedTextField: View {

    enum FocusedField {
        case textField
    }

    @Binding var text: String

    @FocusState private var focusedField: FocusedField?

    var body: some View {
        VStack {
            TextField(LocalizedStringKey("chat.messagePlaceholder"), text: $text, axis: .vertical)
                .focused($focusedField, equals: .textField)
                .padding()

            Spacer()
        }
        .onAppear {
            focusedField = .textField
        }
    }
}

#Preview {
    ExapndedTextField(text: .constant(""))
}
