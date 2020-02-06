
import Foundation

public protocol StackFlowManager: FlowManager {
  var stackFlow: StackFlowCoordinator<Self, VC> { get }
  func getStackFlow() -> StackFlowCoordinator<Self, VC>
}

public extension StackFlowManager {
  /// Returns the current flow
  var stackFlow: StackFlowCoordinator<Self, VC> {
    return flow as! StackFlowCoordinator<Self, Self.VC>
  }
  
  /// Creates a new StackFlow initialized with the conforming ViewModel
  func getStackFlow() -> StackFlowCoordinator<Self, VC> {
    return StackFlowCoordinator(with: self)
  }
}
