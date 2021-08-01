import ArcGIS
import FutureKit

class ArcGisWorker {
    
    private let _router: AnyFetchRouter<FoodApi>
    
    func fetch(
        _ coordinate: Coordinate
    ) -> Future<[AGSGeocodeResult]> {
        return _router.performFetch(.getFood(location: coordinate))
    }
    
    func cancel() {
        _router.cancel()
    }
    
    init(
        _ router: AnyFetchRouter<FoodApi>
    ) {
        _router = router
    }
}
