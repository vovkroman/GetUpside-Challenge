import Foundation
import UIKit

protocol Namable {
    var name: String { get }
}

protocol CoordinatesSupporting {
    var coordinates: Coordinates { get }
}

protocol Imagable {
    var image: UIImage { get }
}

protocol Categorized {
    var categoryId: String { get }
}

extension Main {
        
    final class Builder {
        
        var image: UIImage = UIImage()
        var name: String = String()
        var coordonates: Coordinates = Coordinates()
        var categoryId: String = String()
        
        func image(_ model: Eatery, _ size: CGSize) -> UIImage {
            let request: MapRenderRequest = .pin(category: model.category, size: size)
            return ImageRenderer.render(request)
        }
    }
    
    struct ViewModel: Namable, Imagable, CoordinatesSupporting, Categorized  {
        
        typealias BuilderBlock = (Builder) -> ()
        
        let name: String
        let image: UIImage
        let coordinates: Coordinates
        let categoryId: String
        
        init(_ block: BuilderBlock) {
            let builder = Builder()
            block(builder)
            self.init(builder)
        }
        
        init(_ builder: Builder) {
            name = builder.name
            image = builder.image
            coordinates = builder.coordonates
            categoryId = builder.categoryId
        }
    }
}
