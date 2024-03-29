import ArcGIS
import FutureKit
import Logger

enum FetchError: Error {
    case error(description: String)
}

protocol FetchRouter {
    associatedtype Fetch: FetchType
    func performFetch(_ route: Fetch) -> Future<[AGSGeocodeResult]>
    func cancel()
}

class AnyFetchRouter<Fetch: FetchType>: FetchRouter {
    
    typealias ParamsProvider = (locator: AGSLocatorTask, params: AGSGeocodeParameters)
    
    private var fetchTask: AGSCancelable?
    private var locatorTask: AGSLocatorTask?
    
    func performFetch(
        _ route: Fetch
    ) -> Future<[AGSGeocodeResult]> {
        let promise: Promise<[AGSGeocodeResult]> = Promise()
        do {
            let paramsProvider = try buildParamsProvider(from: route)
            
            locatorTask = paramsProvider.locator
            let params = paramsProvider.params
            
            Logger.debug("\(String(describing: locatorTask)) has been perfromed", category: .api)
            
            fetchTask = locatorTask?.geocode(
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
            Logger.error("\(String(describing: locatorTask?.url)) failed with error \(error)", category: .api)
            promise.reject(with: error)
        }
        
        return promise
    }
    
    func cancel() {
        guard let fetchTask = fetchTask else { return }
        Logger.debug("\(String(describing: locatorTask?.url)) has been canceled", category: .api)
        fetchTask.cancel()
        locatorTask = nil
    }
}

private extension AnyFetchRouter {
    
    private func buildParamsProvider(
        from route: Fetch
    ) throws -> ParamsProvider {
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
}
