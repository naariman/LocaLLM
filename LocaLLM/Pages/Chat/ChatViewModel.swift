//
//  ChatViewModel.swift
//  LocaLLM
//
//  Created by rbkusser on 17.02.2025.
//

import Foundation

class ChatViewModel: ObservableObject {

    private var chatModel: ChatModel? = nil

    @Published var message: String = ""

//    private var request: ChatModel.Request
//    private var response: ChatModel.Response
}
