import Foundation

extension Filter {
    struct Model {
        
        let description: String
        let idx: Int
        
        init(_ description: String, _ idx: Int) {
            self.description = description
            self.idx = idx
        }
    }
}
