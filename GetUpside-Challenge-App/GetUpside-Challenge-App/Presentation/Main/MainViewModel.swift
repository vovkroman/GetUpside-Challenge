import Foundation

protocol Namable {
    var name: String { get }
}

protocol CoordinatesSupporting {
    var coordinates: Coordinates { get }
}

protocol Shapable {
    var shape: Shape { get }
}

extension Main {
    struct ViewModel  {
        typealias Model = Eatery
        
        private let _model: Model
        
        init(_ model: Model) {
            _model = model
        }
    }
}

extension Main.ViewModel: Namable {
    var name: String {
        return _model.name
    }
}

extension Main.ViewModel: Shapable {
    var shape: Shape {
        switch _model {
        case .american, .british, .chinese, .international, .seafood, .fastFood:
            return .restaurante
        case .burger:
            return .burger
        default:
            return .cafe
        }
    }
}

extension Main.ViewModel: CoordinatesSupporting {
    var coordinates: Coordinates {
        return _model.coordinates
    }
}
