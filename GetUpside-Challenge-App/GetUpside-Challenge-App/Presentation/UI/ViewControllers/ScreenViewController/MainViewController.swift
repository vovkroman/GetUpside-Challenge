import UI

protocol ChildUpdatable: UIViewController {
    func update<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel])
}

extension Main {
    
    typealias ViewModelable = Namable & CoordinatesSupporting & Imagable & Typable
    typealias Childable = ChildUpdatable
    
    final class Scene: BaseScene<MainView, InteractorImpl> {
        
        private let overlays: [ChildUpdatable]
        private let filter: Filter.ViewController

        // MARK: - Life Cycle of UIViewController
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // config tabBarMenu
            contentView.tabBarMenu.delegate = self

            // add child view controller to self
            if overlays.isEmpty { return }
            contentView.addChilren(overlays, self)
            
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
            self.overlays = overlays
            self.filter = filter
            super.init(interactor: interactor)
        }
        
        @available(*, unavailable)
        required init(interactor: T) {
            fatalError("init(interactor:) has not been implemented, use init(interactor: InteractorImpl, kids:)")
        }
        
        deinit {
            filter.removeFromParent()
            overlays.forEach { child in
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
    
    func onLoadDidEnd(_ viewModels: [Main.ViewModel]) {
        for overlay in overlays {
            overlay.update(viewModels)
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
