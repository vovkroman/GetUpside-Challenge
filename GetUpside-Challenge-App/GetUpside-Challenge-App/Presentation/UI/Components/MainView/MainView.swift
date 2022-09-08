import ReusableKit

final class MainView: UIView, NibReusable {
    
    @IBOutlet private(set) weak var tabBarMenu: TabBarMenuView!
    @IBOutlet private(set) weak var containerView: UIView!
    
    func updateLayout() {
        tabBarMenu.updateLayout()
    }
        
    func add(_ children: ContiguousArray<UIViewController>, on parent: UIViewController?) {
        for index in stride(from: children.count-1, through: 0, by: -1) {
            let viewController = children[index]
            tabBarMenu.addTabItem(with: viewController.title, at: index)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(viewController.view)
            NSLayoutConstraint.activate([
                viewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                viewController.view.leftAnchor.constraint(equalTo: containerView.leftAnchor),
                viewController.view.rightAnchor.constraint(equalTo: containerView.rightAnchor),
                viewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            parent?.addChild(viewController)
            viewController.didMove(toParent: parent)
        }
        tabBarMenu.selectTab(at: 0)
    }
}