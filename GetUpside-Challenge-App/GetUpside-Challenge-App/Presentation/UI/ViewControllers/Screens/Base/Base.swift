import UIKit
import Logger
import ReusableKit

typealias Viewable = UIView & NibReusable

class BaseComponent<View: Viewable>: UIViewController {
    
    var contentView: View {
        return view as! View
    }
    
    override func loadView() {
        view = View.loadFromNib()
    }
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Logger.debug("\(self) has been removed", category: .lifeCycle)
    }
}

class BaseScene<View: Viewable, InteractorImpl>: BaseComponent<View>, Interactorable {
    
    typealias T = InteractorImpl
    
    let interactor: T
    
    required init(interactor: T) {
        self.interactor = interactor
        super.init()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(*, unavailable)
    required init() {
        fatalError("init() has not been implemented")
    }
    
    deinit {
        Logger.debug("\(self) has been removed", category: .lifeCycle)
    }
}
