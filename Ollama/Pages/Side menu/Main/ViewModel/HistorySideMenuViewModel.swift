//
//  HistorySideMenuViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 28.02.2025.
//

import Foundation

class LeftSideMenuViewModel: ObservableObject {

    @Published var chats = ChatsLocalStorageModel(chats: [])
    private var baseNotificationManager = BaseNotificationManager()

}

extension LeftSideMenuViewModel {

    func didSelectChat(with id: String) {
        baseNotificationManager.trigger(notification: .didSelectChat, object: id)
    }

    func didTapNewChat() {
        baseNotificationManager.trigger(notification: .didTapNewChat)
    }
}
