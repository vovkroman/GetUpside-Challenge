import UIKit
import Logger
import ReusableKit

typealias Viewable = UIView & NibReusable

class BaseViewController<View: Viewable>: UIViewController {
    
    var contentView: View {
        return view as! View
    }
    
    override func loadView() {
        view = View.loadFromNib()
    }
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseScene<View: Viewable, InteractorImpl>: BaseViewController<View>, Interactorable {
    
    typealias T = InteractorImpl
    
    let interactor: T
    
    required init(interactor: T) {
        self.interactor = interactor
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    deinit {
        Logger.debug("\(self) has been removed", category: .lifeCycle)
    }
}