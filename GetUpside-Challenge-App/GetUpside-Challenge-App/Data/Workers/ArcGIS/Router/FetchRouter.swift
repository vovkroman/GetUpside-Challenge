import ArcGIS
import FutureKit

enum FetchError: Error {
    case error(description: String)
}

protocol FetchRouter {
    associatedtype Fetch: FetchType
    func performFetch(_ route: Fetch) -> Future<[AGSGeocodeResult]>
    func cancel()
}

class AnyFetchRouter<Fetch: FetchType>: FetchRouter {
    
    typealias FetchData = (locator: AGSLocatorTask, params: AGSGeocodeParameters)
    
    private var _fetchTask: AGSCancelable?
    private var _locatorTask: AGSLocatorTask?
    
    func performFetch(
        _ route: Fetch
    ) -> Future<[AGSGeocodeResult]> {
        let promise: Promise<[AGSGeocodeResult]> = .init()
        do {
            let fecthdata = try _buildFetch(from: route)
            
            _locatorTask = fecthdata.locator
            let params = fecthdata.params
            
            _fetchTask = _locatorTask?.geocode(
                withSearchText: route.searchResult,
                parameters: params
            ) { (result, error) in
                if let error = error {
                    promise.reject(with: error)
                    return
                }
                if let result = result {
                    promise.resolve(with: result)
                    return
                }
                promise.resolve(with: [])
            }
        } catch let error {
            promise.reject(with: error)
        }
        
        return promise
    }
    
    private func _buildFetch(
        from route: Fetch
    ) throws -> FetchData {
        guard let url = URL(string: route.urlString) else {
            throw FetchError.error(description: "Failed to create URL from \(route.urlString)")
        }
        let locatorTask = AGSLocatorTask(url: url)
        let params = AGSGeocodeParameters()
        
        params.maxResults = route.maxResults
        params.categories = route.categories
        
        params.resultAttributeNames.append(contentsOf: ["*"])
        
        if let location = route.location {
            let point = AGSPoint(clLocationCoordinate2D: location)
            params.preferredSearchLocation = point
            
            // we need to set searchArea here!!!
//            let builder = AGSMultipointBuilder(spatialReference: .wgs84())
//            builder.points.addPointWith(x: point.x + route.span, y: point.y)
//            builder.points.addPointWith(x: point.x - route.span, y: point.y)
//
//            builder.points.addPointWith(x: point.x, y: point.y + route.span)
//            builder.points.addPointWith(x: point.x, y: point.y - route.span)
//
//            params.searchArea = builder.toGeometry()
        }
        return (locatorTask, params)
    }
    
    func cancel() {
        _fetchTask?.cancel()
    }
}
