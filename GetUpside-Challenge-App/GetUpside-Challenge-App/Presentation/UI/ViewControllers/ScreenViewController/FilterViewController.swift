import ReusableKit
import UIKit

extension Filter {
    
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
    
    final class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
        
        typealias ViewModel = Filtered
        
        private var _viewModels: [ViewModel] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            _registerCell()
            _setupView()
        }
        
        // MARK: - Public API
        
        func render(_ viewModels: [ViewModel]) {
            _viewModels.append(contentsOf: viewModels)
            collectionView.reloadData()
        }
        
        // MARK: - Private API
        
        private func _registerCell() {
            collectionView.register(FilterCell.self)
        }
        
        private func _setupView() {
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .clear
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return _viewModels.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell: FilterCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let viewModel = _viewModels[indexPath.row]
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

