import UIKit
import Logger

typealias Viewable = UIView & NibReusable

class BaseScene<View: Viewable, InteractorImpl>: UIViewController, Interactorable {
    
    typealias T = InteractorImpl
    
    let interactor: T
    
    var contentView: View {
        return view as! View
    }
    
    override func loadView() {
        view = View.loadFromNib()
    }
    
    required init(interactor: T) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Logger.debug("\(self) has been removed", category: .lifeCycle)
    }
}
