import UI

protocol Component: UIViewController {
    func onDisplay<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel])
}

extension Main {
    
    typealias ViewModelable = Namable & CoordinatesSupporting & Imagable & Typable
    typealias Childable = Component
    
    final class Scene: BaseScene<MainView, InteractorImpl> {
        
        private let components: [Component]
        private let filter: Filter.ViewController

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
            _ filter: Filter.ViewController
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
    
    func onFilterChanged(_ viewModels: [Filter.ViewModel]) {
        filter.render(viewModels)
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
    
    func onDidSelect<Item : Attributable>(_ component: UIViewController, _ item: Item) {
        interactor.applyFillter(item.attributedString.string)
    }
    
    func onDidDeselect<Item: Attributable>(_ component: UIViewController, _ item: Item) {
        interactor.removeFilter(item.attributedString.string)
    }
    
    func onLocatingDidChage(_ component: UIViewController, _ coordinate: Coordinates) {
        
    }
}
