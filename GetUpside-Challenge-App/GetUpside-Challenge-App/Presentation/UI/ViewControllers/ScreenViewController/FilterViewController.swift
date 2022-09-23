import ReusableKit
import UIKit

extension Filter {
    class ViewController: UICollectionViewController {
        
        private var _viewModels: ContiguousArray<Filter.ViewModel> = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            _registerCell()
            collectionView.backgroundColor = UIColor.white
        }
        
        // MARK: - Congfig methods
        
        private func _registerCell() {
            collectionView.register(FilterCell.self)
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return _viewModels.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell: FilterCell = collectionView.dequeueReusableCell(for: indexPath)
            return cell
        }
        
        required init(_ viewModels: ContiguousArray<Filter.ViewModel>) {
            _viewModels = viewModels
            super.init(collectionViewLayout: UICollectionViewFlowLayout())
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension Filter.ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = _viewModels[indexPath.row]
        return viewModel.size
    }
}

