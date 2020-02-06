
import UIKit

//Allows the UIViewController to be onfigured the Controller with a FlowManager
//This protocol should be conformed by a UIViewController
public protocol Configurable: UIViewController {
  associatedtype VM
  var viewModel: VM! { get set }
  func configure(with viewModel: VM)
}

public extension Configurable {
  /// Injects the dependency ViewModel
  /// - Parameter viewModel: Is the element that will manage the dependencies, navigation included if there is any
  ///
  /// - Note: A Configurable View Controller may or may not be Managed, meaning may or may not be included in any flow
  func configure(with viewModel: VM) {
    self.viewModel = viewModel
  }
}
