
import UIKit

public class StackFlowCoordinator<VM: StackFlowManager, VC: OOFlowManaged>: StackFlow {
  
  weak var viewController: VC?
  weak public var navigationController: UINavigationController?

  public func start() {
    viewController?.viewModel.flow = self as? VC.FM.F
  }
  
  public init(with viewModel: VM, hidingNavigationBar hide: Bool = true) {
    guard let viewModel = viewModel as? VC.VM else { fatalError("This shouldn't be happening") }
    //TODO: Why I can not assign it directly?
    let vController = VC.getConfiguredInstance(with: viewModel)
    viewController = vController
    let navController = UINavigationController(rootViewController: viewController!)
    navController.configureNavigationBar(asHidden: hide)
    navigationController = navController
  }
  
  deinit {
    print("Flow Eliminado")
  }
  
}
