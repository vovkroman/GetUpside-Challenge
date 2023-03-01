import Foundation

extension Convertor {
    
    struct FilterViewModelConverter: Convertable {
        
        typealias From = String
        typealias To = Filter.ViewModel
        
        func convertFromTo(from: String) throws -> Filter.ViewModel {
            let filter = Constant.Filter.self
            let attributes = filter.attributes
            let padding = filter.padding
            
            let size = CGSize(.infinity, filter.height)
            return Filter.ViewModel { builer in
                let attributedString = NSAttributedString(string: from, attributes: attributes)
                let rect = attributedString.boundingRect(with: size, options: [], context: nil)
                
                builer.attributedString = attributedString
                builer.id = "\(from)"
                builer.size = CGSize(rect.width + padding.dx, rect.height + padding.dy)
            }
        }
        
        func convertToFrom(from: Filter.ViewModel) throws -> String {
            // no need convert from Eatery.self to AGSGeocodeResult.self
            throw Error.convertFailed(context: "Could't convert item from \(Filter.ViewModel.self) to \(String.self)")
        }
    }
}
