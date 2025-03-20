//
//  HistorySideMenuViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 28.02.2025.
//

import Foundation

class HistorySideMenuViewModel: ObservableObject {

    private var baseNotificationManager = BaseNotificationManager()

    func didTapNewChat() {
        baseNotificationManager.trigger(notification: .newChatDidTap)
    }
}
