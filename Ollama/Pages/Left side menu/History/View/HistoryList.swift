//
//  HistoryList.swift
//  Ollama
//
//  Created by rbkusser on 22.03.2025.
//

import SwiftUI

struct HistoryList: View {

    @Binding var chats: [ChatLocalStorageModel]
    var didTap: (String) -> ()

    var body: some View {
        VStack(alignment: .leading) {

            if !chats.filter({ $0.timeGroup == .today }).isEmpty {
                Section(header: Text("Today")) {
                    ForEach(chats.filter { $0.timeGroup == .today }) { chat in
                        Text(chat.title)
                            .onTapGesture { didTap(chat.id.description) }
                    }
                }
            }

            if !chats.filter({ $0.timeGroup == .lastSevenDays }).isEmpty {
                Section(header: Text("Last seven days")) {
                    ForEach(chats.filter { $0.timeGroup == .lastSevenDays }) { chat in
                        Text(chat.title)
                            .onTapGesture { didTap(chat.id.description) }
                    }
                }
            }

            if !chats.filter({ $0.timeGroup == .lastMonth }).isEmpty {
                Section(header: Text("Last month")) {
                    ForEach(chats.filter { $0.timeGroup == .lastMonth }) { chat in
                        Text(chat.title)
                            .onTapGesture { didTap(chat.id.description) }
                    }
                }
            }

            if !chats.filter({ $0.timeGroup == .later }).isEmpty {
                Section(header: Text("Later")) {
                    ForEach(chats.filter { $0.timeGroup == .later }) { chat in
                        Text(chat.title)
                            .onTapGesture { didTap(chat.id.description) }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
