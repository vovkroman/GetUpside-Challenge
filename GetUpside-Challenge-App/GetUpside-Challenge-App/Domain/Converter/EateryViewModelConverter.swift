import Foundation

extension Convertor {
    
    struct EateryViewModelConverter: Convertable {
        
        typealias From = Eatery
        typealias To = Main.ViewModel
        typealias Error = Convertor.Error
        
        func convertFromTo(from: Eatery) throws -> Main.ViewModel {
            let map = Constant.Map.self
            let size = map.pinSize
            return Main.ViewModel { builder in
                builder.name = from.name
                builder.categoryId = from.categoryId
                builder.coordonates = from.coordinates
                builder.image = builder.image(from, size)
            }
        }
        
        func convertToFrom(from: Main.ViewModel) throws -> Eatery {
            throw Error("Could't convert item from \(Eatery.self) to \(Main.ViewModel.self)")
        }
    }
}
