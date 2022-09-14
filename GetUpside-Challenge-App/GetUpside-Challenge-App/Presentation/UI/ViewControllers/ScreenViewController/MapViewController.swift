import UIKit
import Logger
import GoogleMaps
import GoogleMapsUtils

final class MapViewController: BaseViewController<MapView> {
    
    var clusterManager: ClusterManagerSupporting!
        
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _applyStyle()
    }
    
    // MARK: - Private API
    
    private func _applyStyle() {
        contentView.applyStyle()
    }
    
    // MARK: - Init methods
    
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
        let pin = Constant.Map.Pin.self
        
        let size = pin.size
        let rect = CGRect(origin: .zero, size: size)
        
        for viewModel in viewModels {
            
            let marker = GMSMarker(position: viewModel.coordinates)
            marker.tracksViewChanges = false
            marker.iconView = PinIconView(viewModel.shape, rect)
            marker.snippet = viewModel.name
            
            marker.appearAnimation = .pop
            clusterManager.add(marker)
        }
        clusterManager.cluster()
    }
}
