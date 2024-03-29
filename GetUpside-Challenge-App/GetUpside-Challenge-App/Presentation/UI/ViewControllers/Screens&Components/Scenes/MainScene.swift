import UI

protocol Component: UIViewController {
    func onLoading()
    func onDisplay<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel])
    func onLocationDidChange(_ coordinates: Coordinates)
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
            
            interactor.onStart()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            contentView.updateLayout()
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            if #available(iOS 13.0, *) {
                return .darkContent
            } else {
                return .`default`
            }
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
            components.forEach { $0.removeFromParent() }
        }
    }
}

extension Main.Scene: MainPresentable {
    
    func onLocationDidChange(_ coordinates: Coordinates) {
        for overlay in components {
            overlay.onLocationDidChange(coordinates)
        }
    }
    
    func onLoading() {
        for overlay in components {
            overlay.onLoading()
        }
    }
    
    func onFilterChanged(_ viewModel: Filter.ViewModel) {
        filter.render(viewModel)
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

extension Main.Scene: SelectionFilterDelegate {
    
    func onDidSelectFilter(_ component: UIViewController, _ type: Filter.`Type`) {
        switch type {
        case .category(let id):
            interactor.applyCategoryFilter(id)
        case .nearMe:
            interactor.applyFilterNearMe(type.id)
        case .default:
            break
        }
    }
    
    func onDidDeselectFilter(_ component: UIViewController, _ type: Filter.`Type`) {
        interactor.removeFilter(type.id)
    }
}

extension Main.Scene: MapActionResolverDelegate {
    
    func onDidAction(_ component: UIViewController, _ coordinate: Coordinates) {
        interactor.fetchingData(coordinate)
    }
}
