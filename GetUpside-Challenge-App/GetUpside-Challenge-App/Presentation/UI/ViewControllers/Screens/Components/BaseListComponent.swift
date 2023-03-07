import UIKit
import ReusableKit

protocol Cellable: UICollectionViewCell, NibReusable {
    associatedtype Configurator
    func configure(_ configurator: Configurator)
}

class BaseListComponent<Cell: Cellable, Configurator: SizeSupportable>: UICollectionViewController, UICollectionViewDelegateFlowLayout where Cell.Configurator == Configurator {
    
    var configurators: [Configurator] = []
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(Cell.self)
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return configurators.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: Cell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        let displayCell = cell as? Cell
        displayCell?.configure(configurators[indexPath.row])
    }
            
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let viewModel = configurators[indexPath.row]
        return viewModel.size
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return .zero
    }
    
    required init(_ layout: UICollectionViewFlowLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
