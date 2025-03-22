//
//  HistoryList.swift
//  Ollama
//
//  Created by rbkusser on 22.03.2025.
//

import SwiftUI

struct HistoryList: View {

    @Binding var chatStorage: ChatsLocalStorageModel
    var didTap: (String) -> ()

    var body: some View {
        VStack(alignment: .leading) {
            chatSection(title: "Today", chats: chatStorage.todayChats)
            chatSection(title: "Last seven days", chats: chatStorage.lastSevenDaysChats)
            chatSection(title: "Last month", chats: chatStorage.lastMonthChats)
            chatSection(title: "Later", chats: chatStorage.laterChats)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    private func chatSection(title: String, chats: [ChatLocalStorageModel]) -> some View {
        if !chats.isEmpty {
            Section(header: Text(title)) {
                ForEach(chats) { chat in
                    Text(chat.title)
                        .onTapGesture { didTap(chat.id.description) }
                }
            }
        }
    }
}
