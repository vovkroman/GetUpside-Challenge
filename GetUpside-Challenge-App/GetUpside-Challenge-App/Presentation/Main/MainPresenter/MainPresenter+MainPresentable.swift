import Foundation

extension Main.Presenter: MainPresenterSupporting {
    
    func onDataDidLoad(_ response: Main.Response) {
        display(convertToEateyViewModel(response.eateries))
        display(convertToFilterViewModels(response.filters))
    }
}

private extension Main.Presenter {
    
    func convertToFilterViewModels(_ models: Main.Filters) -> [Filter.ViewModel] {
        var currIdx = 0
        var viewModels: [Filter.ViewModel] = []
        for model in models {
            viewModels.append(makeFilterViewModel(model, currIdx))
            currIdx += 1
        }
        return viewModels
    }
    
    func convertToEateyViewModel(_ models: Main.Eateries) -> [Main.ViewModel] {
        var currIdx = 0
        var viewModels: [Main.ViewModel] = []
        for model in models {
            viewModels.append(makeEateryViewModel(model, currIdx))
            currIdx += 1
        }
        return viewModels
    }
}

private extension Main.Presenter {
    
    func display(_ viewModels: [Filter.ViewModel]) {
        guard let view = view,
              !viewModels.isEmpty else { return }
        queue.async(execute: combine(viewModels, with: view.onFilterChanged))
    }
    
    func display(_ viewModels: [Main.ViewModel]) {
        guard let view = view,
                !viewModels.isEmpty else { return }
        queue.async(execute: combine(viewModels, with: view.onLoadDidEnd))
    }
}

private extension Main.Presenter {
    
    // create presentable itmes ViewModel
    func makeFilterViewModel(_ model: String, _ idx: Int) -> Filter.ViewModel {
        let filter = Constant.Filter.self
        let attributes = filter.attributes
        let padding = filter.padding
        
        let size = CGSize(.infinity, filter.height)
        return Filter.ViewModel { builer in
            let attributedString = NSAttributedString(string: model.description, attributes: attributes)
            let rect = attributedString.boundingRect(with: size, options: [], context: nil)
            
            builer.attributedString = attributedString
            builer.id = "\(model)"
            builer.row = idx
            builer.size = CGSize(rect.width + padding.dx, rect.height + padding.dy)
        }
    }
    
    // create presentable itmes MainViewModel
    func makeEateryViewModel(_ model: Eatery, _ idx: Int) -> Main.ViewModel {
        let Pin = Constant.Map.Pin.self
        let size = Pin.size
        return Main.ViewModel { builder in
            builder.name = model.name
            builder.type = "\(model.type)"
            builder.coordonates = model.coordinates
            builder.image = builder.build(model, size)
        }
    }
}
