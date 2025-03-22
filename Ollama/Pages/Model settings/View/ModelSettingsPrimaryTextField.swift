//
//  ModelSettingsPrimaryTextField.swift
//  LocaLLM
//
//  Created by rbkusser on 24.02.2025.
//

import SwiftUI

struct ModelSettingsPrimaryTextField: View {

    @Binding var text: String
    @Binding var state: ModelSettingsViewModel.State

    var onChange: () -> ()

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter base URL", text: $text)
                .textContentType(.none)
                .minimumScaleFactor(0.5)
                .textInputAutocapitalization(.none)
                .tint(.black)
                .autocorrectionDisabled()
                .padding(.vertical, 12)
                .padding(.leading, 16)
                .padding(.trailing, 34)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(borderColor(for: state), lineWidth: 1)
                )
                .shadow(radius: 10)
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
                .onChange(of: text) {
                    onChange()
                }
        }
    }


    func borderColor(for state: ModelSettingsViewModel.State) -> Color {
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
    ModelSettingsPrimaryTextField(
        text: .constant(""),
        state: .constant(.loading),
        onChange: {}
    )
}
