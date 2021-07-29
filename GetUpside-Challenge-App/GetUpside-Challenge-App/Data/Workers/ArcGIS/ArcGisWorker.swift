import ArcGIS
import FutureKit

extension ArcGis {
    class Worker {
        
        private let _router: AnyFetchRouter<FoodApi>
        
        func fetch(by coordinate: Coordinate) -> Future<[AGSGeocodeResult]> {
            return _router.performFetch(.getFood(location: coordinate))
        }
        
        func cancel() {
            _router.cancel()
        }
        
        init(_ router: AnyFetchRouter<FoodApi> = .init()) {
            _router = router
        }
    }
}
