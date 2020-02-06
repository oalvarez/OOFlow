

import UIKit

extension UINavigationController {
  /// Helper that hides/shows the navigation bar
  /// - Parameter hide: Boolean value that decides if bar will be hidden
  func configureNavigationBar(asHidden hide: Bool) {
    isNavigationBarHidden = hide
    navigationBar.isHidden = hide
  }
}
