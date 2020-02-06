
import UIKit

//Flow that will take care of the flow of a stack of UIViewControllers
public protocol StackFlow: Flow {
  var navigationController: UINavigationController? { get set }
}

public extension StackFlow {

  /// Present the view controller configured with the viewModel on top of the current stack
  /// - Parameter viewModel: The Flow Manager that will control the flow of this controller
  /// - Parameter hide: Indicates if the Navigation Bar should be hidden or not
  ///
  /// - Note: There is no new navigation created
  ///
  /// - SeeAlso: 'presentViewController'
  func pushViewController<FM: FlowManager>(with viewModel: FM, hidingNavigationBar hide: Bool = false, animated: Bool = true) {
    let controller = viewModel.managedController
    push(controller, hidingNavigationBar: hide, animated: animated)
  }
  
  /// Pushes the view controller configured with the viewModel on top of the current stack
  /// - Parameter controller: The controller to be presented
  /// - Parameter hide: Indicates if the Navigation Bar should be hidden or not
  /// - Parameter animated: Indicates if the Navigation Bar should be hidden or not
  private func push<C: Managed>(_ controller: C, hidingNavigationBar hide: Bool = false, animated: Bool) {
    controller.viewModel.flow = self as? C.FM.F
    navigationController?.configureNavigationBar(asHidden: hide)
    navigationController?.pushViewController(controller, animated: animated)
  }
}

public extension StackFlow {
  
  /// Present the view controller configured with the viewModel as a Modal Scene
  /// - Parameter viewModel: The Flow manager that will control the flow of this controller
  /// - Parameter hide: Indicates if the Navigation Bar should be hidden or not
  /// - Parameter animated: Indicates if the presentations should be animated or not
  ///
  /// - Note: The new view will be presented modally, it will be embeded in a Navigation Controller, so it can have some navigation in it
  ///
  /// - SeeAlso: 'pushViewController'
  func presentViewController<FM: StackFlowManager>(with viewModel: FM, hidingNavigationBar hide: Bool = true, animated: Bool = true) {
    let flow = StackFlowCoordinator<FM, FM.VC>(with: viewModel, hidingNavigationBar: hide)
    flow.start()
    let navController = flow.navigationController!
    presentModally(with: navController, animated: animated)
  }
  
  /// Present the view controller configured with the viewModel as a Modal Scene
  /// - Parameter navController: The Navigation Controller that will be the root of the new navigation
  /// - Parameter animated: Indicates if the presentations should be animated or not
  private func presentModally(with navController: UINavigationController, animated: Bool) {
    navController.transitioningDelegate = (navigationController?.visibleViewController as? UIViewControllerTransitioningDelegate)
    navController.modalPresentationStyle = .overFullScreen
    navigationController?.visibleViewController?.present(navController, animated: animated, completion: nil)
  }
}

public extension StackFlow {
  /// If the current scene is presented over a Modal Presentation, it will dismiss it. If not, then it will pop to the root of the navigation stack
  func stop() {
    if navigationController?.presentingViewController != nil {
      dismissController()
    } else {
      popToRootViewController()
    }
  }
  
  /// It will pop the navigation to the root view controller of the current stack
  func popToRootViewController(animated: Bool = true) {
    navigationController?.popToRootViewController(animated: animated)
  }
  
  /// It remove the top controller of the current stack
  func popController(animated: Bool = true) {
    navigationController?.popViewController(animated: animated)
  }
  
  /// It dismiss the modal presented controller if there is any
  func dismissController(animated: Bool = true) {
    navigationController?.dismiss(animated: animated, completion: nil)
  }
}
