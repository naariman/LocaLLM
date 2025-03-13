//
//  HistorySideMenu.swift
//  LocaLLM
//
//  Created by rbkusser on 28.02.2025.
//

import SwiftUI

struct HistorySideMenu: View {

    @Environment(\.dismiss) var dismiss

    @State private var showProfileSettings = false

    var body: some View {
        ZStack {
            Color.white

            VStack {
                Spacer()

                AppSettingsRow()
                    .onTapGesture {
                        showProfileSettings.toggle()
                    }
            }
        }
        .scrollContentBackground(.hidden)
        .sheet(isPresented: $showProfileSettings) {
            AppSettingsView()
        }
    }
}
