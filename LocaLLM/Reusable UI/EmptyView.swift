//
//  EmptyView.swift
//  LocaLLM
//
//  Created by rbkusser on 24.02.2025.
//

import SwiftUI

struct EmptyView: View {

    let image: Image
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 16) {
            image
                .font(.system(size: 48))
                .foregroundColor(.gray)
                .padding(.bottom, 8)

            Text(title)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(.primary)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    EmptyView(
        image: Image(systemName: "tray.fill"),
        title: "No Models Available",
        subtitle: "It looks like there are no models to display. Please add a new model on your server and reenter URL."
    )
}
