import UI
import FilterKit

protocol MainStateMachineObserver: AnyObject {
    func stateDidChanched(_ stateMachine: Main.StateMachine, _ to: Main.StateMachine.State)
}

protocol MainDataLoadable: AnyObject {
    func onDataDidLoad(_ items: Set<Eatery>)
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


private extension Main.Presenter {
    
    func makeFilterViewModel(_ model: Eatery) -> Filter.ViewModel {
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
    
    func makeMainViewModel(_ model: Eatery) -> Main.ViewModel {
        let Pin = Constant.Map.Pin.self
        let size = Pin.size
        return Main.ViewModel { builder in
            builder.name = model.name
            builder.type = "\(model.type)"
            builder.coordonates = model.coordinates
            builder.image = builder.build(model, size)
        }
    }
}


extension Main.Presenter: MainPresentable {
    
    func onDataDidLoad(_ items: Set<Eatery>) {
        var newMainViewModels: [Main.ViewModel] = []
        var filterViewModels: [Filter.ViewModel] = []
        
        var used: Set<String> = []
        for item in items {
            let mainViewModel = makeMainViewModel(item)
            
            if !used.contains(mainViewModel.id) {
                let filerViewModel = makeFilterViewModel(item)
                filterViewModels.append(filerViewModel)
                used.insert(mainViewModel.id)
            }
            
            newMainViewModels.append(mainViewModel)
        }
        let response = Response(viewModels: newMainViewModels, filters: filterViewModels)
        _queue.sync(execute: combine(.loadingFinished(respons: response), with: _stateMachine.transition))
    }
    
    func locationDidRequestForAuthorization() {
        
    }
    
    func locationDidUpdated(with coordinate: Coordinates) {
        
    }
    
    func locationCatch(the error: Location.Error) {
        
    }
}
