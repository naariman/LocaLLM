//
//  BaseButton.swift
//  LocaLLM
//
//  Created by rbkusser on 15.02.2025.
//

import SwiftUI

struct BaseButton: View {

    var title: LocalizedStringKey
    var action: () -> ()

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 48)
                .foregroundStyle(Color.white)
                .background(Color.black)
                .clipShape(.rect(cornerRadius: 12))
        }
    }
}

#Preview {
    BaseButton(title: "Example", action: {})
}
