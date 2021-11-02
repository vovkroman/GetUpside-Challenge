import ReusableKit

final class ContainerView: UIView, NibReusable {
    
    private(set) weak var child: UIView?
    
    func insertSubview(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.widthAnchor.constraint(equalTo: widthAnchor),
            view.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        child = view
    }
    
    // MARK: - Utils
    func removePreviousView() {
        child?.removeFromSuperview()
        child = nil
    }
}
