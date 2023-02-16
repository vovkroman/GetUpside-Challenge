import UI

protocol ChildUpdatable: UIViewController {
    func update<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel])
}

extension Main {
    
    typealias ViewModelable = Namable & CoordinatesSupporting & Imagable & Identifiable
    typealias Childable = ChildUpdatable
    
    final class Scene: BaseScene<MainView, InteractorImpl> {
        
        private let _children: [ChildUpdatable]
        private let _filter: Filter.ViewController

        // MARK: - Life Cycle of UIViewController
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // config tabBarMenu
            contentView.tabBarMenu.delegate = self

            // add child view controller to self
            if _children.isEmpty { return }
            contentView.addChilren(_children, self)
            
            // config filter
            contentView.filterView.parentViewController = self
            contentView.filterView.childViewController = _filter
            
            interactor.setup()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            contentView.updateLayout()
        }
        
        required init(
            _ interactor: InteractorImpl,
            _ children: [Childable],
            _ filter: Filter.ViewController
        ) {
            self._children = children
            self._filter = filter
            super.init(interactor: interactor)
        }
        
        @available(*, unavailable)
        required init(interactor: T) {
            fatalError("init(interactor:) has not been implemented, use init(interactor: InteractorImpl, kids:)")
        }
        
        deinit {
            _filter.removeFromParent()
            _children.forEach { child in
                child.removeFromParent()
            }
        }
        
        // MARK: - Private API
        
        private func _addItems(_ viewModels: [ViewModel]) {
            for child in _children {
                child.update(viewModels)
            }
        }
        
        private func _addFilters(_ viewModels: [Filter.ViewModel]) {
            _filter.render(viewModels)
        }
        
        // MARK: - State handling
        
        private func _handleState(_ state: Main.StateMachine.State) {
            switch state {
            case .list(let response):
                _addItems(response.viewModels)
                _addFilters(response.filters)
            default:
                break
            }
        }
    }
}

extension Main.Scene: MainStateMachineObserver {
    func stateDidChanched(_ stateMachine: Main.StateMachine, _ to: Main.StateMachine.State) {
        DispatchQueue.main.async(execute: combine(to, with: _handleState))
    }
}

extension Main.Scene: TabBarMenuDelegate {
    func tabBarMenu(_ menu: TabBarMenuView, didSelected index: Int) {
        let vc = children[index]
        contentView.update(vc.title)
        view.bringSubviewToFront(vc.view)
    }
}
