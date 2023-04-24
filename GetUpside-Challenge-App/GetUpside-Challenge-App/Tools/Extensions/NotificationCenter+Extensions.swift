import Foundation

protocol Tokenable: AnyObject {
    func invalidate()
}

protocol TokenObserving {
    func observe(
        name: NSNotification.Name,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @escaping (Notification) -> ()) -> Tokenable
}

class NotificationToken: NSObject {

    let notificationCenter: NotificationCenter
    let token: Any?

    init(notificationCenter: NotificationCenter = .default, token: Any) {
        self.notificationCenter = notificationCenter
        self.token = token
    }

    deinit {
        invalidate()
    }
}

extension NotificationToken: Tokenable {

    // MARK: - TokenObserving implementation
    
    func invalidate() {
        if let token = token {
            notificationCenter.removeObserver(token)
        }
    }
}

extension NotificationCenter: TokenObserving {

    func observe(
        name: NSNotification.Name,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @escaping (Notification) -> ()) -> Tokenable {
            let token = addObserver(forName: name, object: obj, queue: queue, using: block)
            return NotificationToken(notificationCenter: self, token: token)
    }
}
