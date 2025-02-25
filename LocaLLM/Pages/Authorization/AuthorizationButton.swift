//
//  AuthorizationButton.swift
//  LocaLLM
//
//  Created by rbkusser on 16.02.2025.
//

import SwiftUI

struct AuthorizationButton: View {

    var title: LocalizedStringKey
    var image: Image
    var action: () -> ()

    var body: some View {

        Button {
            action()
        } label: {
            Label(title, image: "")
        }

    }
}

#Preview {
    AuthorizationButton(
        title: "Example",
        image: Image("ic_apple"),
        action: {}
    )
}
