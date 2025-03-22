//
//  ChatLocalStorageModel.swift
//  Ollama
//
//  Created by rbkusser on 17.03.2025.
//

import Foundation
import SwiftData

@Model
class ChatsLocalStorageModel {

    var chats: [ChatLocalStorageModel]

    init(chats: [ChatLocalStorageModel]) {
        self.chats = chats
    }

    var todayChats: [ChatLocalStorageModel] {
        chats.filter { $0.timeGroup == .today }
    }

    var lastSevenDaysChats: [ChatLocalStorageModel] {
        chats.filter { $0.timeGroup == .lastSevenDays }
    }

    var lastMonthChats: [ChatLocalStorageModel] {
        chats.filter { $0.timeGroup == .lastMonth }
    }

    var laterChats: [ChatLocalStorageModel] {
        chats.filter { $0.timeGroup == .later }
    }
}

@Model
class ChatLocalStorageModel {

    var id: UUID
    var title: String
    var messages: [ChatMessageLocal]
    var timeGroup: TimePeriod

    init(
        id: UUID,
        title: String,
        messages: [ChatMessageLocal],
        createdAt: Date
    ) {
        self.id = id
        self.title = title
        self.messages = messages
        self.timeGroup = TimePeriod(date: createdAt)
    }
}

enum TimePeriod: Int, Codable, CaseIterable {

    case today = 0
    case lastSevenDays
    case lastMonth
    case later

    init(date: Date) {
        if Calendar.current.isDateInToday(date) {
            self = .today
            return
        }

        let components = Calendar.current.dateComponents(
            [.day],
            from: date,
            to: Date()
        )

        guard let dayDifference = components.day else {
            self = .later
            return
        }

        if dayDifference < 7 {
            self = .lastSevenDays
            return
        }

        if dayDifference < 30 {
            self = .lastMonth
            return
        }

        self = .later
    }
}

@Model
class ChatMessageLocal {

    var id: UUID
    var role: ChatRole
    var content: String

    init(
        id: UUID,
        role: ChatRole,
        content: String
    ) {
        self.id = id
        self.role = role
        self.content = content
    }
}
