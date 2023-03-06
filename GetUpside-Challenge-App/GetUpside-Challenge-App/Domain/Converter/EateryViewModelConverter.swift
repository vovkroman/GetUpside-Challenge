import Foundation

extension Convertor {
    
    struct EateryViewModelConverter: Convertable {
        
        typealias From = Eatery
        typealias To = Main.ViewModel
        
        func convertFromTo(from: Eatery) throws -> Main.ViewModel {
            let Pin = Constant.Map.Pin.self
            let size = Pin.size
            return Main.ViewModel { builder in
                builder.name = from.name
                builder.categoryId = from.categoryId
                builder.coordonates = from.coordinates
                builder.image = builder.image(from, size)
            }
        }
        
        func convertToFrom(from: Main.ViewModel) throws -> Eatery {
            // no need convert from Eatery.self to AGSGeocodeResult.self
            throw Error.convertFailed(context: "Could't convert item from \(Eatery.self) to \(Main.ViewModel.self)")
        }
    }
}
