//
//  LLMSettingsTextField.swift
//  LocaLLM
//
//  Created by rbkusser on 24.02.2025.
//

import SwiftUI

struct LLMSettingsTextField: View {

    let placeholder: LocalizedStringKey

    @Binding var text: String
    @Binding var state: LLMSettingsViewModel.State

    var onChange: () -> ()

    var body: some View {
        TextField(placeholder, text: $text)
            .textInputAutocapitalization(.none)
            .tint(.black)
            .autocorrectionDisabled()
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor(for: state), lineWidth: 1)
            )
            .overlay(
                HStack {
                    Spacer()

                    switch state {
                    case .notEntered:
                        VStack {}
                    case .loading:
                        ProgressView()
                            .padding(.trailing, 16)
                    case .success:
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .padding(.trailing, 16)
                    case .failure:
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .padding(.trailing, 16)
                    }
                }
            )
            .shadow(radius: 10)
            .onChange(of: text) {
                onChange()
            }
    }


    func borderColor(for state: LLMSettingsViewModel.State) -> Color {
        switch state {
        case .loading:
            return .gray.opacity(0.3)
        case .success(let isModelsEmpty):
            return isModelsEmpty ? .gray.opacity(0.3) : .green
        case .failure:
            return .red.opacity(0.5)
        case .notEntered:
            return .gray.opacity(0.3)
        }
    }
}

#Preview {
    LLMSettingsTextField(
        placeholder: LocalizedStringKey("example"),
        text: .constant(""),
        state: .constant(.loading),
        onChange: {}
    )
}
