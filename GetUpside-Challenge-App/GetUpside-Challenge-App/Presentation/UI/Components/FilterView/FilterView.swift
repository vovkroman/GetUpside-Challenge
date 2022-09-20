import ReusableKit

final class FilterView: UIView, NibOwnerLoadable {

    @IBOutlet weak private var _collectionView: UICollectionView!
    
    private var _viewModels: ContiguousArray<Filter.ViewModel> = []
    
    // MARK: - UIView Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNibContent()
        _configCollectionView()
        _registerCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadNibContent()
        _configCollectionView()
        _registerCell()
    }
    
    // MARK: - Config methods
    
    func update(_ viewModels: ContiguousArray<Filter.ViewModel>) {
        _viewModels = viewModels
        _collectionView.reloadData()
    }
    
    private func _configCollectionView() {
        _collectionView.delegate = self
        _collectionView.dataSource = self
    }
    
    private func _registerCell() {
        _collectionView.register(FilterCell.self)
    }
}

extension FilterView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCell = collectionView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return _viewModels[indexPath.row]._size
    }
}
