
import UIKit

//View Controllers conforming to this protocol need to have a viewModel (FlowManager) to manage the cooridinator that controls the flow of the application
public protocol Managed where Self: UIViewController {
  associatedtype FM : FlowManager
  var viewModel: FM! { get set }

}

public extension Managed {
  /// Presents the corresponding View Controller, configured with the viewModel in the indicated view, with no navigation responsabilities
  /// - Parameter viewModel: The element injected in the View Controller that will be presented
  /// - Parameter view: The view where the View Controller will be presented in
  ///
  /// - Note: The Scene presented with this method will not have navigation responsabilities
  ///
  /// - SeeAlso: 'addViewControllerToCurrentFlowConfigured', 'addNewFlowViewControllerConfigured'
  func addViewControllerConfigured<VM: Configurer>(with viewModel: VM, in view: UIView) {
    let viewController = getViewControllerConfigured(with: viewModel)
    add(viewController, in: view)
  }
  
  /// Presents the corresponding View Controller, configured with the viewModel in the indicated view. It can trigger navigation in the current flow.
  /// - Parameter viewModel: The element injected in the View Controller that will be presented
  /// - Parameter view: The view where the View Controller will be presented in
  /// - Parameter hide: Indicates if the Navigation Bar should be hidden or not
  ///
  /// - Note: The ViewModel will be able to trigger any kind of navigation in the current flow. It wont generate new flow
  ///
  /// - SeeAlso: 'addViewControllerConfigured', 'addNewFlowViewControllerConfigured'
  func addViewControllerToCurrentFlowConfigured<FM: StackFlowManager>(with viewModel: FM, in view: UIView, hidingNavigationBar hide: Bool = true) {
    let flow = self.viewModel.flow as? FM.F
    let viewController = getViewControllerToCurrentFlowConfigured(with: viewModel, and: flow)
    add(viewController, in: view)
  }
  
  /// Creates a new navigation with the corresponding View Controller as root, configured with the viewModel and presents it in the indicated view.
  /// - Parameter viewModel: The element injected in the View Controller that will be presented
  /// - Parameter view: The view where the View Controller will be presented in
  /// - Parameter hide: Indicates if the Navigation Bar should be hidden or not
  ///
  /// -  Note: This method will generate a new flow in the view, without affecting the rest of the navigation flow in the application
  ///
  /// - SeeAlso: 'addViewControllerConfigured', 'addViewControllerToCurrentFlowConfigured'
  func addNewFlowViewControllerConfigured<FM: StackFlowManager>(with viewModel: FM, in view: UIView, hidingNavigationBar hide: Bool = true) {
    let navController = getNewFlowViewControllerConfigured(with: viewModel)
    add(navController, in: view)
  }
}

public extension Managed  {
  //TODO: Tab bar stuff
  func addTabBar<T: TabbedController>(_ type: T.Type, from data: Data, in view: UIView, hidingNavigationBar hide: Bool = true, animated: Bool = true) {
    let flow = viewModel.flow as? Flow
    let tabBarController = getTheTabBar(type, from: data, and: flow)
    add(tabBarController, in: view)
  }
}

