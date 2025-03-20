//
//  BaseNotificationManager.swift
//  Ollama
//
//  Created by rbkusser on 20.03.2025.
//

import Foundation

public protocol BaseNotificationManagerDelegate: AnyObject {
    func performOnTrigger(_ notification: BaseNotification, object: Any?, userInfo: [AnyHashable: Any]?)
}


class BaseNotificationManager {

    private let notificationCenter = NotificationCenter.default
    public weak var delegate: BaseNotificationManagerDelegate?

    public init() {}

    public init(delegate: BaseNotificationManagerDelegate) { self.delegate = delegate }

    public func subscribe(to notification: BaseNotification, object: Any? = nil) {
        notificationCenter.addObserver(self, selector: #selector(selector), name: notification.name, object: object)
    }

    public func unsubscribe(from notification: BaseNotification, object: Any? = nil) {
        notificationCenter.removeObserver(self, name: notification.name, object: object)
    }

    public func trigger(notification: BaseNotification, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        notificationCenter.post(name: notification.name, object: object, userInfo: userInfo)
    }

    @objc private func selector(_ notification: Notification) {
        let baseNotification = BaseNotification(name: notification.name)
        delegate?.performOnTrigger(baseNotification, object: notification.object, userInfo: notification.userInfo)
    }
}

public class BaseNotification: RawRepresentable, Equatable {

    public typealias RawValue = String
    public let rawValue: RawValue

    public var name: Notification.Name { .init(rawValue: rawValue) }

    required public init(rawValue: String = #function) {
        self.rawValue = rawValue
    }

    convenience public init(name: Notification.Name) {
        self.init(rawValue: name.rawValue)
    }
}

extension BaseNotification {

    static var newChatDidTap: BaseNotification { .init() }
}
