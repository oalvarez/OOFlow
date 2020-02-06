
import Foundation

public enum SceneType {
  case tabBar(Data)
  case navigation(StackFlow, Bool)
  
  /// Initializer for the case of Stack Navigation
  /// - Parameter vm: The View Model (Or FlowManager that will manage the navigation of the first Controller of the Stack
  /// - Parameter hide: Indicates if the Navigation Bar should be hidden or not
  public init<FM: StackFlowManager>(with vm:FM, hide: Bool) {
    let flow = StackFlowCoordinator<FM, FM.VC>(with: vm, hidingNavigationBar: hide)
    self = .navigation(flow, hide)
  }
}
