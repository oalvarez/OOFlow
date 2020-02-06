
import UIKit

public class SceneStackFlow: SceneFlow {
  
  public var window: UIWindow
  public var stack: StackFlow
  public var hidden: Bool
  
  /// A Scene Stack Flow is a type of Scene Flow that is able to present and handle a Stack of controllers on the scene. Is  a Root of the Flow managment done in a window when there are not Tab Bar Involved
  /// - Parameter flowManager: The View Model conforming to StackFlowManager that will be presented on scene
  /// - Parameter window: The window where the Stack Flow is presented
  /// - Parameter hidden: Indicates if the Navigation Bar should be hidden or not
  required public init<FM: StackFlowManager>(with flowManager: FM, in window: UIWindow, hidden: Bool = true) {
     self.window = window
     self.stack = flowManager.getStackFlow()
     self.hidden = hidden
   }
  
  /// Initiates the process
  public func start() {
    updateScene()
  }
  
  /// Updates the stack and presents it on the scene as the root of the Window
  /// - Parameter stack: The Stack Flow we want to be present as the root of the window
  public func updateStack(with stack: StackFlow) {
    self.stack = stack
    updateScene()
  }
  
  /// Get a Flow View Controller from the first Stack Flow that will be presented on the scene. And then, presents it
  func updateScene() {
    present(getNewFlowViewControllerConfigured(with: stack))
  }
  
  //TODO: We want to be able to pass a transition
  /// Sets the passed View Controller as the root of the Window, with a default transition
  /// - Parameter viewController: The View Controller that will be the root of the Window
  func present(_ viewController: UIViewController) {
    let transition = CATransition()
    transition.type = .fade
    window.set(rootViewController: viewController, withTransition: transition)
  }
  
  deinit {
    print("Flow Eliminado")
  }
}
