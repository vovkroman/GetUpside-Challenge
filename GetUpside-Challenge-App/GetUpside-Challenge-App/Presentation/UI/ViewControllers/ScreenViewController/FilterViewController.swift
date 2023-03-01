import ReusableKit
import UIKit

extension Filter {
    
    typealias ViewModelable = Attributable & SizeSupportable
    
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
        
        private var viewModels: [ViewModelable] = []
        
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
        
        override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            let viewModel = viewModels[indexPath.row]
            print("Did select: \(viewModel.attributedString)")
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

private extension Filter.ViewController {
    
    func registerCell() {
        collectionView.register(FilterCell.self)
    }
    
    func setupView() {
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
    }
}

