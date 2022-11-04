import UI

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
        
        let size = CGSize(.infinity, filter.height)
        return Filter.ViewModel { builer in
            let attributedString = NSAttributedString(string: model.description, attributes: attributes)
            let rect = attributedString.boundingRect(with: size, options: [], context: nil)
            
            builer.attributedString = attributedString
            builer.size = CGSize(rect.width, rect.height)
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
            
            if !used.contains(mainViewModel.type) {
                let filerViewModel = _buildFilterViewModel(item)
                filterViewModels.append(filerViewModel)
                used.insert(mainViewModel.type)
            }
            
            itemViewModels.append(mainViewModel)
        }
        
        _queue.sync(execute: combine(.loadingFinished(respons: Response(viewModels: itemViewModels, filters: filterViewModels)), with: _stateMachine.transition))
    }
    
    func locationDidRequestForAuthorization() {
        
    }
    
    func locationDidUpdated(with coordinate: Coordinates) {
        
    }
    
    func locationCatch(the error: Location.Error) {
        
    }
}
