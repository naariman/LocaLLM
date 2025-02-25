//
//  AuthorizationView.swift
//  LocaLLM
//
//  Created by rbkusser on 15.02.2025.
//

import SwiftUI

struct AuthorizationView: View {

    var body: some View {
        VStack {
            Spacer()

            Image(systemName: "network")
                .resizable()
                .frame(width: 64, height: 64)

            Spacer()

            Label {
                Text("authorization.continueWithAppleButton")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .medium))
            } icon: {
                Image("ic_apple")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(.black)
            .clipShape(.rect(cornerRadius: 12))
            .padding(.horizontal)

            Label {
                Text("authorization.continueWithGoogleButton")
                    .foregroundStyle(.white)
                    .font(.system(size: 16, weight: .medium))
            } icon: {
                Image("ic_google")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(.black)
            .clipShape(.rect(cornerRadius: 12))
            .padding(.horizontal)
        }
    }
}

#Preview {
    AuthorizationView()
}
