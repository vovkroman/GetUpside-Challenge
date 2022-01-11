import Foundation
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
        
        private let _model: Model
        
        init(_ model: Model) {
            _model = model
        }
    }
}

extension Splash.ViewModel: ActionaSupporting, ButtonTitlable, Descriptionable {
    
    var isEnabled: Bool {
        if case .denied = _model {
            return true
        }
        return false
    }
    
    var action: Action? {
        if case .denied = _model {
            let url = URL(string: UIApplication.openSettingsURLString)!
            return combine(url, [:], with: UIApplication.shared.openURL)
        } else {
            return nil
        }
    }
    
    var title: String {
        if case .denied = _model {
            return "Go to Settings ..."
        } else {
            return ""
        }
    }
    
    var description: String {
        switch _model {
        case .denied, .restricted, .unknown:
            return _model.description
        case .other(let error):
            return error.localizedDescription
        }
    }
}


extension Splash.ViewModel: Equatable {
    static func == (
        lhs: Splash.ViewModel,
        rhs: Splash.ViewModel
    ) -> Bool {
        return lhs._model == rhs._model
    }
}
