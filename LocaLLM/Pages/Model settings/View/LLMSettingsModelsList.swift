//
//  LLMSettingsModelsList.swift
//  LocaLLM
//
//  Created by rbkusser on 24.02.2025.
//

import SwiftUI

struct LLMSettingsModelsList: View {

    @Binding var models: [LLMModel]
    @Binding var selectedModel: LLMModel?

    var body: some View {
        List(models) { model in
            HStack {
                Text(model.name)
                    .padding(.vertical, 4)
                Spacer()
                if model.id == selectedModel?.id {
                    Image(systemName: "checkmark")
                        .foregroundColor(.black)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                selectedModel = model
            }

        }
        .listStyle(.plain)
    }
}
