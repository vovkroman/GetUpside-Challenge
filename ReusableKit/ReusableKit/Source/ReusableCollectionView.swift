import UIKit

extension UICollectionView {
    @inlinable
    public func register<T: UICollectionViewCell>(
        _ cellType: T.Type
    ) where T: Reusable & NibLoadable {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    @inlinable
    final public func register<T: UICollectionViewCell>(
        _ cellType: T.Type
    ) where T: Reusable {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    @inlinable
    final public func dequeueReusableCell<T: UICollectionViewCell>(
        for indexPath: IndexPath, cellType: T.Type = T.self
    ) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self).")
        }
        
        return cell
    }
    
    @inlinable
    final public func register<T: UICollectionReusableView>(
        _ supplementaryViewType: T.Type,
        ofKind elementKind: String
    ) where T: Reusable & NibLoadable {
        register(supplementaryViewType.nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: supplementaryViewType.reuseIdentifier)
    }
    
    @inlinable
    final public func register<T: UICollectionReusableView>(
        _ supplementaryViewType: T.Type,
        ofKind elementKind: String
    ) where T: Reusable {
        register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: supplementaryViewType.reuseIdentifier)
    }
    
    @inlinable
    final public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(
        ofKind elementKind: String,
        for indexPath: IndexPath,
        viewType: T.Type = T.self
    ) -> T where T: Reusable {
        let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: viewType.reuseIdentifier, for: indexPath)
        guard let typedView = view as? T else {
            fatalError("Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) matching type \(viewType.self).")
        }
        
        return typedView
    }
}
