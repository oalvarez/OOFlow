
import Foundation

public protocol Configurer {
  associatedtype VC: OOConfigurable
}

public extension Configurer {
  /// Creates a View Controller and configures it with the current ViewModel (Self)
  var managedController: VC {
    return VC.getConfiguredInstance(with: self as! VC.VM)
  }
}
