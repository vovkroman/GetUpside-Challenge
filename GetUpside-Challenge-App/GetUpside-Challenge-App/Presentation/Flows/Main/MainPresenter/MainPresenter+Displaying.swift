import Foundation

extension Main.Presenter {
    
    func display(_ viewModel: Filter.ViewModel) {
        guard let view = view else { return }
        queue.async(execute: combine(viewModel, with: view.onFilterChanged))
    }
    
    func display(_ viewModels: [Main.ViewModel]) {
        guard let view = view else { return }
        queue.async(execute: combine(viewModels, with: view.onDisplay))
    }
}
