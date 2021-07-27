import Foundation

protocol FetchType {
    var urlString: String { get }
    var searchResult: String { get }
    var categories: [String] { get }
    var span: Double { get }
    var location: Location.Coordinate? { get }
    var maxResults: Int { get }
}
