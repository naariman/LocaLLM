//
//  BaseNotificationManager.swift
//  Ollama
//
//  Created by rbkusser on 20.03.2025.
//

import Foundation

extension BaseNotification {

    static var didTapNewChat: BaseNotification { .init() }
    static var didSelectChat: BaseNotification { .init() }
    static var didUpdateModelSettings: BaseNotification { .init() }
}


protocol BaseNotificationManagerDelegate: AnyObject {

    func performOnTrigger(_ notification: BaseNotification, object: Any?, userInfo: [AnyHashable: Any]?)
}

class BaseNotificationManager {

    private let notificationCenter = NotificationCenter.default
    weak var delegate: BaseNotificationManagerDelegate?

    init() {}

    init(delegate: BaseNotificationManagerDelegate) { self.delegate = delegate }

    func subscribe(to notification: BaseNotification, object: Any? = nil) {
        notificationCenter.addObserver(self, selector: #selector(selector), name: notification.name, object: object)
    }

    func unsubscribe(from notification: BaseNotification, object: Any? = nil) {
        notificationCenter.removeObserver(self, name: notification.name, object: object)
    }

    func trigger(notification: BaseNotification, object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        notificationCenter.post(name: notification.name, object: object, userInfo: userInfo)
    }

    @objc private func selector(_ notification: Notification) {
        let baseNotification = BaseNotification(name: notification.name)
        delegate?.performOnTrigger(baseNotification, object: notification.object, userInfo: notification.userInfo)
    }
}

class BaseNotification: RawRepresentable, Equatable {

    typealias RawValue = String
    let rawValue: RawValue

    var name: Notification.Name { .init(rawValue: rawValue) }

    required init(rawValue: String = #function) {
        self.rawValue = rawValue
    }

    convenience init(name: Notification.Name) {
        self.init(rawValue: name.rawValue)
    }
}
