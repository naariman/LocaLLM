//
//  ConnectionStatusView.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import SwiftUI

struct ConnectionStatusView: View {

    @Binding var isConnected: Bool

    var body: some View {
        HStack {
            Circle()
                .frame(width: 8)
                .foregroundStyle(isConnected ? .green : .red)

            Text(LocalizedStringKey(isConnected ? "common.connectionAvailable" : "common.connectionUnavailable"))
                .font(.system(size: 14, weight: .regular))
        }
    }
}

#Preview {
    ConnectionStatusView(isConnected: .constant(false))
}
