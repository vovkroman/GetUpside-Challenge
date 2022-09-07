import Foundation

extension Main {
    struct ViewModel {
        typealias Model = Eatery
        
        private let _model: Model
        
        var coordinates: Coordinates {
            return _model.coordinates
        }
        
        var name: String {
            return _model.name
        }
        
        init(_ model: Model) {
            _model = model
        }
    }
}
