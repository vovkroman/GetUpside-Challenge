import UIKit

public protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
}

public extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}

public extension NibLoadable where Self: UIView {
    @inlinable
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
    
    @inlinable
    func setupFromNib() {
        let view = Self.loadFromNib()
        addSubview(view)
    }
}
