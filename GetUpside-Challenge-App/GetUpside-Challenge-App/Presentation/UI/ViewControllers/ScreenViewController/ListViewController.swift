import UIKit
import ReusableKit
import Logger

final class ListViewController: UITableViewController {
    
    private var viewModels: [Main.ViewModelable] = []
    
    // MARK: - Private API
    
    private func configTableView() {
        tableView.register(EateryCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EateryCell = tableView.dequeueReusableCell(for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let displatCell = cell as? EateryCell
        displatCell?.configure(viewModels[indexPath.row])
    }
    
    deinit {
        Logger.debug("\(self) has been removed", category: .lifeCycle)
    }
}

extension ListViewController: Component {
    
    func onDisplay<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel]) {
        self.viewModels = viewModels
        tableView.reloadData()
    }
}
