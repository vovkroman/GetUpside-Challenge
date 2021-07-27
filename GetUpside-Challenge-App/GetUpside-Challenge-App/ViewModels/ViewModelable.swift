import Foundation

protocol ViewModelable {
    associatedtype T
    
    init(viewModel: T)
}
