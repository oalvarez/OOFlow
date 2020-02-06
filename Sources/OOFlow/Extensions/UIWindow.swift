
import UIKit

public extension UIWindow {
  
  /// Substitute the current View Controller from the root of the Window and sets the View Controller passed as the root
  /// - Parameter newRootViewController: The View Controller that will be presented as root
  /// - Parameter transition: The Type of transition to be applyed
  func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {
    
    let previousViewController = rootViewController
    
    if let transition = transition {
      layer.add(transition, forKey: kCATransition)
    }
    
    rootViewController = newRootViewController

    if UIView.areAnimationsEnabled {
      UIView.animate(withDuration: CATransaction.animationDuration()) {
        newRootViewController.setNeedsStatusBarAppearanceUpdate()
      }
    } else {
      newRootViewController.setNeedsStatusBarAppearanceUpdate()
    }
    
    /// The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
    if let transitionViewClass = NSClassFromString("UITransitionView") {
      for subview in subviews where subview.isKind(of: transitionViewClass) {
        subview.removeFromSuperview()
      }
    }
    if let previousViewController = previousViewController {
      // Allow the view controller to be deallocated
      previousViewController.dismiss(animated: false) {
        // Remove the root view in case its still showing
        previousViewController.view.removeFromSuperview()
      }
    }
  }
}

