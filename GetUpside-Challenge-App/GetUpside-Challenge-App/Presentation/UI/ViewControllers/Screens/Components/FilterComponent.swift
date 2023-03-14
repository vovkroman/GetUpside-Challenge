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
        
        private var headerConfigurators: [HeaderConfigurator] = []
        weak var delegate: SelectionFilterDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            registerHeader()
            setupView()
        }
        
        // MARK: - Public API
        
        func render(_ cells: [CellConfigurator], _ headers: [HeaderConfigurator]) {
            self.configurators = cells
            self.headerConfigurators = headers
            collectionView.reloadData()
        }
        
        override func numberOfSections(in collectionView: UICollectionView) -> Int {
            return headerConfigurators.count
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
            headerView.configure(headerConfigurators[indexPath.section])
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
            return headerConfigurators[section].size
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
    
    func onSelect(_ configurator: Filter.CellConfigurator) {
        if configurator.isSelected {
            delegate?.onDidSelectFilter(self, configurator.type)
        } else {
            delegate?.onDidDeselectFilter(self, configurator.type)
        }
    }
}
