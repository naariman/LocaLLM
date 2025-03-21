//
//  ChatLocalStorageModel.swift
//  Ollama
//
//  Created by rbkusser on 17.03.2025.
//

import Foundation
import SwiftData

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

    var displayName: String {
        switch self {
        case .today: return "Today"
        case .lastSevenDays: return "Last seven days"
        case .lastMonth: return "Last month"
        case .later: return "Later"
        }
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
