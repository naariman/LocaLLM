//
//  ProfileSettingsView.swift
//  LocaLLM
//
//  Created by rbkusser on 12.03.2025.
//

import SwiftUI

struct AppSettingsView: View {

    @StateObject private var viewModel = AppSettingsViewModel()
    @Environment(\.dismiss) var dismiss

    @State private var showClearChatsAlert = false

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle.fill")
                }
                .foregroundStyle(.secondary)
                .padding(.trailing)
            }
            .overlay {
                Text(LocalizedStringKey("appSettings.title"))
                    .font(.headline)
            }
            .padding(16)

            Form {

                Section {
                    LanguageSelectionRow(selectedLanguage: $viewModel.selectedLanguage)
                    AppearanceSelectionRow(selectedAppearance: $viewModel.selectedAppearance)
                }

                Section {
                    Button(action: {
                        showClearChatsAlert = true
                    }, label: {
                        HStack {
                            Spacer()
                            Text(LocalizedStringKey("appSettings.clearChats"))
                                .foregroundStyle(.red)
                            Spacer()
                        }
                    })
                    .alert(LocalizedStringKey("appSettings.deleteChats.alert.message"), isPresented: $showClearChatsAlert) {
                        Button(LocalizedStringKey("common.cancel"), role: .cancel) { showClearChatsAlert = false }
                        Button(LocalizedStringKey("common.delete"), role: .destructive) { viewModel.didTapClearChats() }
                    }
                }
            }
        }
        .background(Color(uiColor: UIColor.systemGroupedBackground))
    }
}

#Preview {
    AppSettingsView()
}
