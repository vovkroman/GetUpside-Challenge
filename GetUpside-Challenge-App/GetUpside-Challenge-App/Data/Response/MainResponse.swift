import Foundation

extension Main {
    struct Response {
        let eateries: [Eatery]
        let filters: Filters
        
        init(_ eateries: [Eatery], _ filters: Filters) {
            self.eateries = eateries
            self.filters = filters
        }
    }
}
