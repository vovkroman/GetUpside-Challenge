import UIKit
import Logger

typealias Viewable = UIView & NibReusable

class BaseViewController<View: Viewable, ViewModel>: UIViewController, ViewModelable {
    
    typealias T = ViewModel
    
    let viewModel: T
    
    var contentView: View {
        return view as! View
    }
    
    override func loadView() {
        view = View.loadFromNib()
    }
    
    required init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Logger.debug("\(self) has been removed", category: .lifeCycle)
    }
}
