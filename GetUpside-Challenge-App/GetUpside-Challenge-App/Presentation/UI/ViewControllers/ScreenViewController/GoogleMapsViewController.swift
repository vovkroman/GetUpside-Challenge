import UIKit
import GoogleMaps
import GoogleMapsUtils

final class GoogleMapsViewController: BaseViewController<MapView> {
    
    private var _viewModels: [Main.ViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        _setupMapStyle()
    }
    
    // MARK: - Private methods
    
    private func _setupMapStyle() {
        contentView.setupMapStyle()
    }
}
