
import UIKit

public protocol Storyboarded: UIViewController {
  static var storyboardName: String? { get }
}

internal extension Storyboarded {
  /// This method returns an instance of the View Controller.
  /// If the conforming View Controller implements the storyboardName property, it will use the get the View Controller from the corresponding Storyboard
  static func getInstance() -> Self {
    guard let storyboardName = storyboardName else {
      return Self()
    }
    let bundle = Bundle(for: self)
    let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
    return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! Self
  }
}

internal extension Storyboarded where Self: Configurable {
  /// This method returns an instance of the View Controller configured with the corresponding ViewModel.
  /// If the conforming View Controller implements the storyboardName property, it will use the get the View Controller from the corresponding Storyboard
  /// - Parameter viewModel: The ViewModel that will encapsulate the logic attached to the View Controller
  static func getConfiguredInstance(with viewModel: VM) -> Self {
    let controller = Self.getInstance()
    controller.configure(with: viewModel)
    return controller
  }
}

extension Storyboarded {
  public static var storyboardName: String? { return nil }
}

/// To conform by a Controller that will be configurated with a View Model, but WILL NOT be Managed as a navigation screen
public typealias OOConfigurable = Storyboarded & Configurable

/// To conform by a Controller that will be configurated with a View Model, and WILL BE Managed as a navigation screen
public typealias OOFlowManaged = OOConfigurable & Managed
