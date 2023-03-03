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
    
    final class Builder {
        var id: String = ""
        var size: CGSize = .zero
        var attributedString: NSAttributedString = NSAttributedString()
        var isSelected: Bool = false
    }
    
    class ViewModel {
        
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
}

extension Filter.ViewModel: Attributable, SizeSupportable, Selectable {
    func toggle() {
        isSelected = !isSelected
    }
}
