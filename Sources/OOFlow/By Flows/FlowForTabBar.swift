
import UIKit

internal extension Flow {
  //Presents the tab bar when passing the data
  func getTabBar<T: TabbedController>(_ type: T.Type, from data: Data) -> UITabBarController {
    return getTheTabBar(type, from: data, and: self)
  }
}
