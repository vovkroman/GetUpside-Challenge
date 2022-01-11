import UIKit
import FutureKit

extension UIApplication {
    func openURL(url: URL, options: [OpenExternalURLOptionsKey: Any]) -> Future<Bool> {
        let promise = Promise<Bool>()
        open(url, options: options) { isComplete in
            promise.resolve(with: isComplete)
        }
        return promise
    }
}
