import ArcGIS
import FutureKit
//import RealmSwift

enum ArcGis {}

// Interface for Items worker (use case), to get items (eateries from either Local DB or ArgisAPI)
protocol GetEateriesUseCase: AnyObject {
    func fetchData(_ coordinate: Coordinates) -> Future<[Eatery]>
    func cancelFetching()
}

extension ArcGis {
    final class Worker {
        
        private let _router: AnyFetchRouter<FoodApi>
        
        func fetch(
            _ coordinate: Coordinates
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
    
    func fetchData(_ coordinate: Coordinates) -> Future<[Eatery]> {
        let converter = Convertor.EateryConverter()
        return fetch(coordinate)
               .transformed { results in
                   return results.compactMap{ try? converter.convertFromTo(from: $0) }
               }
    }
}
