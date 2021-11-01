import Foundation

final class SplashContainerView: UIView, NibReusable {
    
    private(set) weak var child: SplashableView?
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.widthAnchor.constraint(equalTo: widthAnchor),
            view.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        child = view as? SplashableView
    }
    
    
    func removePrevious() {
        child?.removeFromSuperview()
        child = nil
    }
}