
import Foundation

/// This a protocol to be conformed by en Enum that lists all the cases of View Controllers (O Scenes) that will be candidates to be presented on a Tab Bar
///
/// - Note: An extension on Data is implemented to get the information to present on the tab bar from a json file in the bundle
public protocol TabbedController: Codable {
  func getFlow() -> StackFlow
  static var data: Data { get }
}
