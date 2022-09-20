import UIKit
import Logger

final class ListViewController: UITableViewController {
    
    private var _viewModels: ContiguousArray<Main.ViewModelable> = []
    
    // MARK: - Private API
    
    private func _configTableView() {
        tableView.register(EateryCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _configTableView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EateryCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let displatCell = cell as? EateryCell
        displatCell?.configure(_viewModels[indexPath.row])
    }
    
    deinit {
        Logger.debug("\(self) has been removed", category: .lifeCycle)
    }
}

extension ListViewController: ChildUpdatable {
    
    func update<ViewModel: Main.ViewModelable>(_ viewModels: ContiguousArray<ViewModel>) {
        //_viewModels = ContiguousArray(viewModels)
        tableView.reloadData()
    }
}
