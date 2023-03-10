import UI

protocol Component: UIViewController {
    func onDisplay<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel])
}

extension Main {
    
    typealias ViewModelable = Namable & CoordinatesSupporting & Imagable & Categorized
    typealias Childable = Component
    
    final class Scene: BaseScene<MainView, InteractorImpl> {
        
        private let components: [Component]
        private let filter: Filter.Component

        // MARK: - Life Cycle of UIViewController
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // config tabBarMenu
            contentView.tabBarMenu.delegate = self

            // add child view controller to self
            if components.isEmpty { return }
            contentView.addChilren(components, self)
            
            // config filter
            contentView.filterView.parentViewController = self
            contentView.filterView.childViewController = filter
            
            interactor.onInitialLoad()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            contentView.updateLayout()
        }
        
        required init(
            _ interactor: InteractorImpl,
            _ overlays: [Childable],
            _ filter: Filter.Component
        ) {
            self.components = overlays
            self.filter = filter
            super.init(interactor: interactor)
        }
        
        @available(*, unavailable)
        required init(interactor: T) {
            fatalError("init(interactor:) has not been implemented, use init(interactor: InteractorImpl, kids:)")
        }
        
        deinit {
            filter.removeFromParent()
            components.forEach { child in
                child.removeFromParent()
            }
        }
    }
}

extension Main.Scene: MainPresentable {
    
    func onLoading() {
        ////
    }
    
    func onFilterChanged(_ viewModel: Filter.ViewModel) {
        filter.render(viewModel.cells, viewModel.headers)
    }
    
    func onDisplay(_ viewModels: [Main.ViewModel]) {
        for overlay in components {
            overlay.onDisplay(viewModels)
        }
    }
}

extension Main.Scene: TabBarMenuDelegate {
    func tabBarMenu(_ menu: TabBarMenuView, didSelected index: Int) {
        let vc = children[index]
        contentView.update(vc.title)
        view.bringSubviewToFront(vc.view)
    }
}

extension Main.Scene: SelectionDelegate, LocatingDelegate {
    
    func onSelect(_ component: UIViewController, _ id: String, _ isSelected: Bool) {
        if id == Filter.CustomId.nearMe.rawValue {
            interactor.applyFilterNearMe()
            return
        }
        if isSelected {
            interactor.applyCategoryFilter(id)
        } else {
            interactor.removeCategoryFilter(id)
        }
    }
    
    func onLocatingDidChage(_ component: UIViewController, _ coordinate: Coordinates) {
        interactor.fetchingData(coordinate)
    }
}
