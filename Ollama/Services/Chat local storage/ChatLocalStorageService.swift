//
//  ChatLocalStorageService.swift
//  Ollama
//
//  Created by rbkusser on 17.03.2025.
//

import Foundation
import SwiftData

//class ChatStorageService {
//    private let modelContainer: ModelContainer
//    private let modelContext: ModelContext
//
//    // MARK: - Initialization
//
//    init() throws {
//        let schema = Schema([ChatLocalStorageModel.self, ChatMessageLocal.self])
//        self.modelContainer = try ModelContainer(for: schema)
//        self.modelContext = ModelContext(modelContainer)
//    }
//
//    // MARK: - Create Operations
//
//    func createChat(title: String, initialMessage: String? = nil) -> ChatLocalStorageModel {
//        var messages: [ChatMessageLocal] = []
//
//        if let initialMessage = initialMessage {
//            let message = ChatMessageLocal(
//                id: UUID(),
//                role: .user, // Assuming ChatRole enum has a user case
//                content: initialMessage
//            )
//            messages.append(message)
//        }
//
//        let chat = ChatLocalStorageModel(
//            id: UUID(),
//            title: title,
//            messages: messages,
//            createdAt: Date()
//        )
//
//        modelContext.insert(chat)
//        try? modelContext.save()
//
//        return chat
//    }
//
//    func addMessage(to chat: ChatLocalStorageModel, role: ChatRole, content: String) -> ChatMessageLocal {
//        let message = ChatMessageLocal(
//            id: UUID(),
//            role: role,
//            content: content
//        )
//
//        chat.messages.append(message)
//        try? modelContext.save()
//
//        return message
//    }
//
//    // MARK: - Read Operations
//
//    func fetchAllChats() -> [ChatLocalStorageModel] {
//        do {
//            let descriptor = FetchDescriptor<ChatLocalStorageModel>(
//                sortBy: [SortDescriptor(\.timeGroupValue), SortDescriptor(\.title)]
//            )
//            return try modelContext.fetch(descriptor)
//        } catch {
//            print("Failed to fetch chats: \(error)")
//            return []
//        }
//    }
//
//    func fetchChat(withID id: UUID) -> ChatLocalStorageModel? {
//        let predicate = #Predicate<ChatLocalStorageModel> { chat in
//            chat.id == id
//        }
//
//        let descriptor = FetchDescriptor<ChatLocalStorageModel>(predicate: predicate)
//
//        do {
//            let results = try modelContext.fetch(descriptor)
//            return results.first
//        } catch {
//            print("Failed to fetch chat: \(error)")
//            return nil
//        }
//    }
//
//    func fetchChats(inTimeGroup timeGroup: ChatLocalStorageModel.TimeGroup) -> [ChatLocalStorageModel] {
//        let predicate = #Predicate<ChatLocalStorageModel> { chat in
//            chat.timeGroup == timeGroup
//        }
//
//        let descriptor = FetchDescriptor<ChatLocalStorageModel>(
//            predicate: predicate,
//            sortBy: [SortDescriptor(\.title)]
//        )
//
//        do {
//            return try modelContext.fetch(descriptor)
//        } catch {
//            print("Failed to fetch chats by time group: \(error)")
//            return []
//        }
//    }
//
//    // MARK: - Update Operations
//
//    func updateChatTitle(_ chat: ChatLocalStorageModel, newTitle: String) {
//        chat.title = newTitle
//        try? modelContext.save()
//    }
//
//    // MARK: - Delete Operations
//
//    func deleteChat(_ chat: ChatLocalStorageModel) {
//        modelContext.delete(chat)
//        try? modelContext.save()
//    }
//
//    func deleteMessage(_ message: ChatMessageLocal, from chat: ChatLocalStorageModel) {
//        if let index = chat.messages.firstIndex(where: { $0.id == message.id }) {
//            chat.messages.remove(at: index)
//            modelContext.delete(message)
//            try? modelContext.save()
//        }
//    }
//
//    func deleteAllChats() {
//        let chats = fetchAllChats()
//        for chat in chats {
//            modelContext.delete(chat)
//        }
//        try? modelContext.save()
//    }
//}
//
