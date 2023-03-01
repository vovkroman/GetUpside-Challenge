import Foundation

extension Main.Presenter {
    
    func display(_ viewModels: [Filter.ViewModel]) {
        guard let view = view,
              !viewModels.isEmpty else { return }
        queue.async(execute: combine(viewModels, with: view.onFilterChanged))
    }
    
    func display(_ viewModels: [Main.ViewModel]) {
        guard let view = view,
                !viewModels.isEmpty else { return }
        queue.async(execute: combine(viewModels, with: view.onLoadDidEnd))
    }
}
