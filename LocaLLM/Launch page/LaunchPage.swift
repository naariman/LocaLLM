//
//  LaunchPage.swift
//  LocaLLM
//
//  Created by rbkusser on 15.02.2025.
//

import SwiftUI

struct LaunchPage: View {

    @Binding var showLaunchPage: Bool

    var body: some View {
        VStack {

        }
        .onAppear {
            self.showLaunchPage = false
        }
    }
}
