import Foundation

extension Filter {
    
    final class Builder {
        var size: CGSize = .zero
        var attributedString: NSAttributedString = NSAttributedString()
    }
    
     final class ViewModel {
        
        typealias BuilderBlock = (Builder) -> ()
        
        let _size: CGSize
        let _attributedString: NSAttributedString
        
         convenience init(_ block: BuilderBlock) {
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
