import ArcGIS
import FutureKit

enum ArcGis {}

// Interface for Items worker (use case), to get items (eateries from either Local DB or ArgisAPI)
protocol GetEateriesUseCase: AnyObject {
    func fetchData(_ coordinate: Coordinates) -> Future<[Eatery]>
    func cancelFetching()
}

protocol EateriesSavable: AnyObject {
    func save(_ eateries: [Eatery])
}

extension ArcGis {
    final class Worker {
        
        private let router: AnyFetchRouter<FoodApi>
        
        func fetch(
            _ coordinate: Coordinates
        ) -> Future<[AGSGeocodeResult]> {
            return router.performFetch(.getFood(location: coordinate))
        }
        
        func cancel() {
            router.cancel()
        }
        
        init(
            _ router: AnyFetchRouter<FoodApi>
        ) {
            self.router = router
        }
    }
}

extension ArcGis.Worker: GetEateriesUseCase {
    func cancelFetching() {
        cancel()
    }
    
    func fetchData(_ coordinate: Coordinates) -> Future<[Eatery]> {
        let converter = Convertor.AGSGeocodeResultEateryConverter()
        return fetch(coordinate)
               .transformed { results in
                   return results.compactMap{ try? converter.convertFromTo(from: $0) }
               }
    }
}
