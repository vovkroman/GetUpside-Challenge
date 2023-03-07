import Foundation

extension Convertor {
    
    struct FilterViewModelConverter: Convertable {
        typealias From = Set<String>
        typealias To = Filter.ViewModel
        
        
        func createCellConfigurator(from: String) -> Filter.CellConfigurator {
            let filter = Constant.Filter.self
            let attributes = filter.attributes
            let padding = filter.padding
            
            let size = CGSize(.infinity, filter.height)
            return Filter.CellConfigurator { builer in
                let attributedString = NSAttributedString(string: from, attributes: attributes)
                let rect = attributedString.boundingRect(with: size, options: [], context: nil)
                
                builer.attributedString = attributedString
                builer.id = "\(from)"
                builer.size = CGSize(rect.width + padding.dx, rect.height + padding.dy)
            }
        }
        
        func createHeaderConfigurator() -> Filter.HeaderConfigurator {
            let request: ConfigRenderRequest = .filtering(size: CGSize(50, 50))
            return Filter.HeaderConfigurator { builder in
                builder.image = ImageRenderer.render(request)
            }
        }
        
        func convertFromTo(from: Set<String>) throws -> Filter.ViewModel {
            var cellsConfigurators: [Filter.CellConfigurator] = []
            for item in from {
                cellsConfigurators.append(createCellConfigurator(from: item))
            }
            return Filter.ViewModel(
                [createHeaderConfigurator()],
                cellsConfigurators
            )
        }
        
        func convertToFrom(from: Filter.ViewModel) throws -> Set<String> {
            // no need convert from Eatery.self to AGSGeocodeResult.self
            throw Error.convertFailed(context: "Could't convert item from \(Filter.ViewModel.self) to \([String].self)")
        }
    }
}
