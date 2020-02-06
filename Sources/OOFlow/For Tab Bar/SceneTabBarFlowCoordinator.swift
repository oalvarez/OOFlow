
import UIKit

public class SceneTabBarFlow<T: TabbedController>: SceneFlow {
  
  public var window: UIWindow
  public var sceneType: SceneType
  
  /// A Scene StackTabBarFlow is a type of Scene Flow that is able to present and handle TabBarController  presentation on a scene as well as a Stack of controllers. Is  a Root of the Flow managment done in a window when there are not Tab Bar Involved
  /// - Parameter sceneType: Indicates if the Controller presented is a Stack or a Tab bar
  /// - Parameter window: The Window where the corresponding Controller will be presented
  ///
  /// - SeeAlso: 'SceneStackFlow'
  required public init(with sceneType: SceneType, in window: UIWindow) {
    self.window = window
    self.sceneType = sceneType
  }
  
  /// Initiates the process
  public func start() {
    updateScene()
  }
  
  /// By updating the type, we are able to change what will be presented as the root of the Window
  /// - Parameter sceneType: Indicates what will be presented. TabBar or a Navigation Controller
  public func updateType(with sceneType: SceneType) {
    self.sceneType = sceneType
    updateScene()
  }
  
  /// Gets the corrensponding Controller acording to the type, and presents it on scene as the root of the Window
  func updateScene() {
    switch sceneType {
    case .tabBar(let value):
      present(getTabBar(T.self, from: value))
    case .navigation(let value, let hidden):
      present(getNewFlowViewControllerConfigured(with: value, hiddenNavController: hidden))
    }
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
    print("Flow Deallocated")
  }
}
