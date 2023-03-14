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
    
    enum CustomId: String, CustomStringConvertible {
        case nearMe = "near-me"
        case `default` = "default"
        
        var description: String {
            return rawValue
        }
    }
    
    enum `Type` {
        case category(String)
        case nearMe
        case `default`
        
        var id: String {
            switch self {
            case .category(let id): return id
            case .nearMe:
                return "\(CustomId.nearMe)"
            default:
                return "\(CustomId.default)"
            }
        }
    }
    
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
            var type: `Type` = .default
            var size: CGSize = .zero
            var attributedString: NSAttributedString = NSAttributedString()
            var isSelected: Bool = false
        }
        
        typealias BuilderBlock = (Builder) -> ()
        
        let type: `Type`
        let size: CGSize
        let attributedString: NSAttributedString
        var isSelected: Bool
        
        convenience init(_ block: BuilderBlock) {
            let builder = Builder()
            block(builder)
            self.init(builder)
        }
        
        init(_ builder: Builder) {
            type = builder.type
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
        let size: CGSize
        
        convenience init(_ block: BuilderBlock) {
            let builder = Builder()
            block(builder)
            self.init(builder)
        }
        
        init(_ builder: Builder) {
            image = builder.image
            size = image.size
        }
    }
}

extension Filter.CellConfigurator: Attributable, SizeSupportable, Selectable {
    func toggle() {
        isSelected = !isSelected
    }
}
