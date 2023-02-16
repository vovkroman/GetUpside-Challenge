import UI
import FilterKit

protocol MainStateMachineObserver: AnyObject {
    func stateDidChanched(_ stateMachine: Main.StateMachine, _ to: Main.StateMachine.State)
}

protocol MainDataLoadable: AnyObject {
    func dataDidLoaded(_ items: Set<Eatery>)
}

extension Main {
    final class Presenter {

        private let _stateMachine: StateMachine = StateMachine()
        private let _queue: DispatchQueue
        private let _executor: FilterExecutor<Eatery> = FilterExecutor<Eatery>()
        
        weak var observer: MainStateMachineObserver? {
            didSet {
                _stateMachine.observer = observer
            }
        }
        
        init(_ queue: DispatchQueue) {
            _queue = queue
        }
    }
}

extension Main.Presenter: MainPresentable {
    
    private func _buildFilterViewModel(_ model: Eatery) -> Filter.ViewModel {
        let filter = Constant.Filter.self
        let attributes = filter.attributes
        let padding = filter.padding
        
        let size = CGSize(.infinity, filter.height)
        return Filter.ViewModel { builer in
            let attributedString = NSAttributedString(string: model.description, attributes: attributes)
            let rect = attributedString.boundingRect(with: size, options: [], context: nil)
            
            builer.attributedString = attributedString
            builer.id = "\(model.type)"
            builer.size = CGSize(rect.width + padding.dx, rect.height + padding.dy)
        }
    }
    
    private func _buildMainViewModel(_ model: Eatery) -> Main.ViewModel {
        let Pin = Constant.Map.Pin.self
        let size = Pin.size
        return Main.ViewModel { builder in
            builder.name = model.name
            builder.type = "\(model.type)"
            builder.coordonates = model.coordinates
            builder.image = builder.build(model, size)
        }
    }
    
    func dataDidLoaded(_ items: Set<Eatery>) {
        var itemViewModels: [Main.ViewModel] = []
        var filterViewModels: [Filter.ViewModel] = []
        
        var used: Set<String> = Set()
        for item in items {
            let mainViewModel = _buildMainViewModel(item)
            
            if !used.contains(mainViewModel.id) {
                let filerViewModel = _buildFilterViewModel(item)
                filterViewModels.append(filerViewModel)
                used.insert(mainViewModel.id)
            }
            
            itemViewModels.append(mainViewModel)
        }
        let response = Response(viewModels: itemViewModels, filters: filterViewModels)
        _queue.sync(execute: combine(.loadingFinished(respons: response), with: _stateMachine.transition))
    }
    
    func locationDidRequestForAuthorization() {
        
    }
    
    func locationDidUpdated(with coordinate: Coordinates) {
        
    }
    
    func locationCatch(the error: Location.Error) {
        
    }
}
