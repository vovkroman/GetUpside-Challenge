import UIKit

protocol Attributable {
    var attributedString: NSAttributedString { get }
}

protocol SizeSupportable {
    var size: CGSize { get }
}

protocol Selectable {
    func toggle()
    var isSelected: Bool { get set }
}

extension Filter {
    
    struct ViewModel {
        let headers: [HeaderConfigurator]
        let cells: [CellConfigurator]
        
        init(_ headers: [HeaderConfigurator], _ cells: [CellConfigurator]) {
            self.cells = cells
            self.headers = headers
        }
    }
    
    class CellConfigurator {
        
        final class Builder {
            var id: String = ""
            var size: CGSize = .zero
            var attributedString: NSAttributedString = NSAttributedString()
            var isSelected: Bool = false
        }
        
        typealias BuilderBlock = (Builder) -> ()
        
        let id: String
        let size: CGSize
        let attributedString: NSAttributedString
        var isSelected: Bool
        
        convenience init(_ block: BuilderBlock) {
            let builder = Builder()
            block(builder)
            self.init(builder)
        }
        
        init(_ builder: Builder) {
            // unique identifier for filter item
            id = builder.id
            attributedString = builder.attributedString
            
            // size of item
            size = builder.size
            isSelected = builder.isSelected
        }
    }
    
    class HeaderConfigurator {
        class Builder {
            var image: UIImage = UIImage()
        }
        
        typealias BuilderBlock = (Builder) -> ()

        let image: UIImage
        
        convenience init(_ block: BuilderBlock) {
            let builder = Builder()
            block(builder)
            self.init(builder)
        }
        
        init(_ builder: Builder) {
            image = builder.image
        }
    }
}

extension Filter.CellConfigurator: Attributable, SizeSupportable, Selectable {
    func toggle() {
        isSelected = !isSelected
    }
}
