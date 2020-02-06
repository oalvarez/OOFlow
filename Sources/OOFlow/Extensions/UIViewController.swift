//
//  UIViewController.swift
//  ByFoot
//
//  Created by Oscar Alvarez on 31/08/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import UIKit

public extension UIViewController {
  /// Adds a View Controller as a child of current controller in the specified view
  /// - Parameter viewContoller: The View Controller to add
  /// - Parameter view: The View where the View Controller will be added
  func add(_ viewContoller: UIViewController, in view: UIView) {
    addChild(viewContoller)
    view.addSubview(viewContoller.view)
    viewContoller.view.pinToSuperview()
    viewContoller.didMove(toParent: self)
  }
  
  /// Remove the view Controller from its parent
  func remove() {
    guard parent != nil else {
      return
    }
    willMove(toParent: nil)
    removeFromParent()
    view.removeFromSuperview()
  }
}
