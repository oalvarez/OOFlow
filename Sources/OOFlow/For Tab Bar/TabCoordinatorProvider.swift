
import UIKit

public struct TabFlowProvider {
  /// Creates and returns a flow related to the View Controller and View Model assigned to a Tab in a Tab bar
  /// - Parameter section: Contains the information for the tab in the tab bar: The View Controller, the title and the Images.
  static func getTabFlow(for section: Tab) -> StackFlow {
    let flow = section.type.getFlow()
    flow.start()
    flow.navigationController?.tabBarItem.title = section.title
    flow.navigationController?.tabBarItem.image = UIImage(named: section.unselectedImage)
    flow.navigationController?.tabBarItem.selectedImage = UIImage(named: section.selectedImage)
    return flow
  }
}
