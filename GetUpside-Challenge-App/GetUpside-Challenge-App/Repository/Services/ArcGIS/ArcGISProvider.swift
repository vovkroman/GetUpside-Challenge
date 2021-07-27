import ArcGIS
import FutureKit

class ArcGISProvider {
    
    private let _router: AnyFetchRouter<FoodApi>
    
    func fetch(by coordinate: Location.Coordinate) -> Future<[AGSGeocodeResult]> {
        return _router.performFetch(.getFood(location: coordinate))
    }
    
    func cancel() {
        _router.cancel()
    }
    
    init(_ router: AnyFetchRouter<FoodApi> = .init()) {
        _router = router
    }
}
