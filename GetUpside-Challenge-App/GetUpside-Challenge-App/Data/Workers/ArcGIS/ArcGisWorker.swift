import ArcGIS
import FutureKit

enum ArcGis {}

// Interface for Items worker (use case), to get items (eateries from either Local DB or ArgisAPI)
protocol GetEateriesUseCase: AnyObject {
    func fetchData(_ coordinate: Coordinate) -> Future<[Eatery]>
    func cancelFetching()
}

extension ArcGis {
    final class Worker {
        
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
}

extension ArcGis.Worker: GetEateriesUseCase {
    func cancelFetching() {
        cancel()
    }
    
    func fetchData(_ coordinate: Coordinate) -> Future<[Eatery]> {
        return fetch(coordinate)
                .transformed { results in results.compactMap(Eatery.init) }
    }
}
