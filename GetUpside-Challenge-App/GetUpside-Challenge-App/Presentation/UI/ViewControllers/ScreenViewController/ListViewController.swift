import UIKit

final class ListViewController: UITableViewController, ChildUpdatable {
    func update<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel]) {}
}
