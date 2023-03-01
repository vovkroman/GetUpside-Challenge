import Foundation

extension Main {
    struct Response {
        let eateries: Eateries
        let filters: Filters
        
        init(_ eateries: Eateries, _ filters: Filters) {
            self.eateries = eateries
            self.filters = filters
        }
    }
}
