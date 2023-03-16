import ReusableKit
import UIKit

protocol SelectionFilterDelegate: AnyObject {
    func onDidSelectFilter(_ component: UIViewController, _ type: Filter.`Type`)
    func onDidDeselectFilter(_ component: UIViewController, _ type: Filter.`Type`)
}

extension Filter {
        
    final class HorizontalLayout: UICollectionViewFlowLayout {
        
        override init() {
            super.init()
            scrollDirection = .horizontal
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    final class Component: BaseListComponent<FilterCell, Filter.CellConfigurator> {
        
        private var headerConfig: NSAttributedString =  NSAttributedString()
        
        weak var delegate: SelectionFilterDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            registerHeader()
            setupView()
        }
        
        // MARK: - Public API
        
        func render(_ viewModel: Filter.ViewModel) {
            switch viewModel {
            case .inital(let cells, let headerConfig):
                self.configurators = cells
                self.headerConfig = headerConfig
                collectionView.reloadData()
            case .update(let cellConfigs):
                let (indexPathes, cells) = (cellConfigs.indexPathes, cellConfigs.cells)
                addCells(cells, indexPathes)
            }
        }
        
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        override func collectionView(
            _ collectionView: UICollectionView,
            viewForSupplementaryElementOfKind kind: String,
            at indexPath: IndexPath
        ) -> UICollectionReusableView {
            let headerView: FilterHeaderView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                for: indexPath
            )
            headerView.configure(headerConfig)
            return headerView
        }
                
        override func collectionView(
            _ collectionView: UICollectionView,
            didSelectItemAt indexPath: IndexPath
        ) {
            configurators[indexPath.row].toggle()
            onSelect(configurators[indexPath.row])
        }
        
        override func collectionView(
            _ collectionView: UICollectionView,
            didDeselectItemAt indexPath: IndexPath
        ) {
            configurators[indexPath.row].toggle()
            onSelect(configurators[indexPath.row])
        }
        
        override func collectionView(
            _ collectionView: UICollectionView,
            layout collectionViewLayout: UICollectionViewLayout,
            referenceSizeForHeaderInSection section: Int
        ) -> CGSize {
            return CGSize(100.0, 50.0)
        }
        
        required init() {
            super.init(HorizontalLayout())
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @available(*, unavailable)
        required init(_ layout: UICollectionViewFlowLayout) {
            fatalError("init(_:) has not been implemented")
        }
    }
}

private extension Filter.Component {
    
    func registerHeader() {
        let sectionHeader = UICollectionView.elementKindSectionHeader
        collectionView.register(
            FilterHeaderView.self,
            ofKind: sectionHeader
        )
    }
    
    func setupView() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
    }
    
    func addCells(
        _ new: [Filter.CellConfigurator],
        _ indexPathes: [IndexPath]
    ) {
        configurators.append(contentsOf: new)
        collectionView.performBatchUpdates {
            collectionView.insertItems(at: indexPathes)
        }
    }
    
    func onSelect(_ configurator: Filter.CellConfigurator) {
        if configurator.isSelected {
            delegate?.onDidSelectFilter(self, configurator.type)
        } else {
            delegate?.onDidDeselectFilter(self, configurator.type)
        }
    }
}
