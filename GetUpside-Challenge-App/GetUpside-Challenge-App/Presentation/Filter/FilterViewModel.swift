import UIKit

protocol Attributable {
    var attributedString: NSAttributedString { get }
}

protocol SizeSupportable {
    var size: CGSize { get }
}

extension Filter {
    
    class Builder {
        var size: CGSize = .zero
        var attributedString: NSAttributedString = NSAttributedString()
        var type: Eatery.`Type` = .default
    }
    
    struct ViewModel {
        
        typealias BuilderBlock = (Builder) -> ()
        
        private let _size: CGSize
        private let _attributedString: NSAttributedString
        
         init(_ block: BuilderBlock) {
            let builder = Builder()
            block(builder)
            self.init(builder)
        }
        
        init(_ builder: Builder) {
            _size = builder.size
            _attributedString = builder.attributedString
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
