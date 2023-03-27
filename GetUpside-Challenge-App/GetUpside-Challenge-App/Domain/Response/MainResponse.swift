import Foundation

extension Main {
    struct Response {
        let eateries: [Main.Model]
        let filters: [Filter.Model]
        
        init(_ eateries: [Eatery], _ filters: [Filter.Model]) {
            self.eateries = eateries
            self.filters = filters
        }
    }
}
