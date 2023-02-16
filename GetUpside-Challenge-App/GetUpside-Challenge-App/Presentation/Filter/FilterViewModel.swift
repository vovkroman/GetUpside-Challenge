import UIKit

protocol Attributable {
    var attributedString: NSAttributedString { get }
}

protocol SizeSupportable {
    var size: CGSize { get }
}

extension Filter {
    
    final class Builder {
        var id: String = ""
        var size: CGSize = .zero
        var attributedString: NSAttributedString = NSAttributedString()
    }
    
    struct ViewModel {
        
        typealias BuilderBlock = (Builder) -> ()
        
        private let _id: String
        private let _size: CGSize
        private let _attributedString: NSAttributedString
        
         init(_ block: BuilderBlock) {
            let builder = Builder()
            block(builder)
            self.init(builder)
        }
        
        init(_ builder: Builder) {
            // unique identifier for filter item
            _id = builder.id
            _attributedString = builder.attributedString
            
            // size of item
            _size = builder.size
        }
    }
}

extension Filter.ViewModel: Attributable, SizeSupportable {
    
    var attributedString: NSAttributedString {
        return _attributedString
    }
    
    var size: CGSize {
        return _size
    }
}
