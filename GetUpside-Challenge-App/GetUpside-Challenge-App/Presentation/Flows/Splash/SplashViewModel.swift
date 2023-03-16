import UIKit
import FutureKit

typealias Action = () -> Future<Bool>

protocol ActionaSupporting {
    var action: Action? { get }
}

protocol ButtonTitlable {
    var isEnabled: Bool { get }
    var title: String { get }
}

protocol Descriptionable {
    var description: String { get }
}

extension Splash {
    struct ViewModel {
        typealias Model = Location.Error
        
        private let model: Model
        
        init(_ model: Model) {
            self.model = model
        }
    }
}

extension Splash.ViewModel: ActionaSupporting, ButtonTitlable, Descriptionable {
    
    var isEnabled: Bool {
        if case .denied = model {
            return true
        }
        return false
    }
    
    var action: Action? {
        if case .denied = model {
            let url = URL(string: UIApplication.openSettingsURLString)!
            return combine(url, [:], with: UIApplication.shared.openURL)
        } else {
            return nil
        }
    }
    
    var title: String {
        if case .denied = model {
            return "Go to Settings ..."
        } else {
            return ""
        }
    }
    
    var description: String {
        switch model {
        case .denied, .restricted, .unknown:
            return model.description
        case .other(let error):
            return error.localizedDescription
        }
    }
}
