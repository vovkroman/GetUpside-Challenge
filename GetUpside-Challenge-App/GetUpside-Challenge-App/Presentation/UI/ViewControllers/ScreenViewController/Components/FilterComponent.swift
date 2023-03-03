import ReusableKit
import UIKit

protocol SelectionDelegate: AnyObject {
    func onDidSelect<Item: Attributable>(_ component: UIViewController, _ item: Item)
    func onDidDeselect<Item: Attributable>(_ component: UIViewController, _ item: Item)
}

extension Filter {
    
    typealias ViewModelable = Attributable & SizeSupportable & Selectable
    
    final class CollectionViewFlowLayout: UICollectionViewFlowLayout {
        
        override init() {
            super.init()
            scrollDirection = .horizontal
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    final class Component: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        
        private var viewModels: [ViewModelable] = []
        
        weak var delegate: SelectionDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            registerCell()
            setupView()
        }
        
        // MARK: - Public API
        
        func render(_ viewModels: [ViewModel]) {
            self.viewModels = viewModels
            collectionView.reloadData()
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModels.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell: FilterCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
        override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            let displayCell = cell as? FilterCell
            displayCell?.configure(viewModels[indexPath.row])
        }
                
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            viewModels[indexPath.row].toggle()
            didSelect(viewModels[indexPath.row])
        }
        
        override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            viewModels[indexPath.row].toggle()
            didSelect(viewModels[indexPath.row])
        }
                
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let viewModel = viewModels[indexPath.row]
            return viewModel.size
        }
        
        required init() {
            let layout = CollectionViewFlowLayout()
            super.init(collectionViewLayout: layout)
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

private extension Filter.Component {
    
    func registerCell() {
        collectionView.register(FilterCell.self)
    }
    
    func setupView() {
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.allowsMultipleSelection = true
    }
    
    func didSelect(_ viewModel: Filter.ViewModelable) {
        if viewModel.isSelected {
            delegate?.onDidSelect(self, viewModel)
        } else {
            delegate?.onDidDeselect(self, viewModel)
        }
    }
}

