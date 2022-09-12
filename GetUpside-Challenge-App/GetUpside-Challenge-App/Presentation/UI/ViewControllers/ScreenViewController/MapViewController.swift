import UIKit
import GoogleMaps
import GoogleMapsUtils

final class MapViewController: BaseViewController<MapView> {
    
    var clusterManager: ClusterManagerSupporting!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.applyStyle()
    }
    
    // MARK: - Private methods
    
    required init(_ clusterManager: ClusterManagerSupporting) {
        self.clusterManager = clusterManager
        super.init()
    }
    
    required init() {
        super.init()
    }
}

extension MapViewController: ChildUpdatable {
    
    func update<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel]) {
        for viewModel in viewModels {
            let marker = GMSMarker(position: viewModel.coordinates)
            marker.tracksViewChanges = false
            marker.iconView = PinIconView(viewModel.shape, CGRect(origin: .zero, size: CGSize(width: 50, height: 50.0)))
            marker.snippet = viewModel.name
            
            marker.appearAnimation = .pop
            clusterManager.add(marker)
        }
    }
}
