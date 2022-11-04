import UIKit
import ReusableKit

open class ContainerView: UIView, NibReusable {
    
    open weak var parentViewController: UIViewController?
    open weak var childViewController: UIViewController? {
        willSet {
            childViewController?.willMove(toParent: nil)
            childViewController?.view.removeFromSuperview()
            childViewController?.removeFromParent()
        }
        
        didSet {
            guard let childViewController = childViewController else { return }
            childViewController.view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(childViewController.view)
            NSLayoutConstraint.activate([
                childViewController.view.centerXAnchor.constraint(equalTo: centerXAnchor),
                childViewController.view.centerYAnchor.constraint(equalTo: centerYAnchor),
                childViewController.view.widthAnchor.constraint(equalTo: widthAnchor),
                childViewController.view.heightAnchor.constraint(equalTo: heightAnchor)
            ])
            parentViewController?.addChild(childViewController)
            childViewController.didMove(toParent: parentViewController)
        }
    }
}
