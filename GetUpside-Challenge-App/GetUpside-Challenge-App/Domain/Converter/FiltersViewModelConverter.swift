import Foundation

extension Convertor {
    
    struct FiltersViewModelConverter: Convertable {
        typealias From = Set<String>
        typealias To = Filter.ViewModel
        
        func convertFromTo(from: Set<String>) throws -> Filter.ViewModel {
            var cellsConfigurators: [Filter.CellConfigurator] = []
            for item in from {
                cellsConfigurators.append(makeCellConfigurator(from: item))
            }
            cellsConfigurators.append(makeCellConfigurator(from: "near me (20 km)"))
            return Filter.ViewModel(
                [makeHeaderConfigurator()],
                cellsConfigurators
            )
        }
        
        func convertToFrom(from: Filter.ViewModel) throws -> Set<String> {
            throw Error.convertFailed(context: "Could't convert item from \(Filter.ViewModel.self) to \([String].self)")
        }
    }
}

private extension Convertor.FiltersViewModelConverter {
    
    func makeCellConfigurator(from: String) -> Filter.CellConfigurator {
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
    
    func makeHeaderConfigurator() -> Filter.HeaderConfigurator {
        let filter = Constant.Filter.self
        
        let request: ConfigRenderRequest = ConfigRenderRequest(size: filter.size)
        return Filter.HeaderConfigurator { builder in
            builder.image = ImageRenderer.render(request)
        }
    }
}
