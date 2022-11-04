import UI
import Logger
import GoogleMaps
import GoogleMapsUtils

final class MapViewController: BaseViewController<MapView> {
    
    var clusterManager: ClusterManagerSupporting!
        
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _setup()
    }
    
    // MARK: - Private API
    
    private func _setup() {
        contentView.applyStyle()
        contentView.delegate = self
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

extension MapViewController: GMSMapViewDelegate {
    // TODO: implememnt GMSMapViewDelegate delegate
}

extension MapViewController: ChildUpdatable {
    
    func update<ViewModel: Main.ViewModelable>(_ viewModels: [ViewModel]) {
        typealias PinIconImage = IconView
        
        for viewModel in viewModels {
            let marker = GMSMarker(position: viewModel.coordinates)
            
            let image = viewModel.image
            let pinIconView = PinIconImage(image: image)
            marker.iconView = pinIconView
            
            marker.snippet = viewModel.name
            
            marker.appearAnimation = .pop
            clusterManager.add(marker)
        }
        clusterManager.cluster()
    }
}
