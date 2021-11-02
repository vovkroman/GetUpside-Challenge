import UIKit

extension UITableView {
    @inlinable
    final public func register<T: UITableViewCell>(
        _ cellType: T.Type
    ) where T: Reusable & NibLoadable {
        register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }

    @inlinable
    final public func register<T: UITableViewCell>(
        _ cellType: T.Type
    ) where T: Reusable {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    @inlinable
    final public func register<T: UITableViewHeaderFooterView>(
        _ headerFooterViewType: T.Type
    ) where T: Reusable & NibLoadable {
        register(headerFooterViewType.nib, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    @inlinable
    final public func register<T: UITableViewHeaderFooterView>(
        _ headerFooterViewType: T.Type
    ) where T: Reusable {
        register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    @inlinable
    final public func dequeueReusableCell<T: UITableViewCell>(
        for indexPath: IndexPath,
        with cellType: T.Type = T.self) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).")
        }
        
        return cell
    }

    @inlinable
    final public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(
        _ viewType: T.Type = T.self
    ) -> T? where T: Reusable {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
            fatalError("Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) matching type \(viewType.self).")
        }
        
        return view
    }
}
