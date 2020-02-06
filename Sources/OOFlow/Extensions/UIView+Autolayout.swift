//
//  UIView+Autolayout.swift
//  ByFoot
//
//  Created by Oscar Alvarez on 31/08/2018.
//  Copyright © 2018 Oscar Alvarez. All rights reserved.
//

import UIKit

public extension UIView {
  
  /// Adjust the view to pin its edges to the superwie's. The view will fill all the superview space
  /// - Parameter safely: True to use safe area, false to use superview
  /// - Parameter top: distance value to the top edge
  /// - Parameter leading: distance value to the leading edge
  /// - Parameter bottom: distance value to the bottom edge
  /// - Parameter trailing: distance value to the trailing edge
  func pinToSuperview(safely: Bool = false, top: CGFloat? = 0, leading: CGFloat? = 0, bottom: CGFloat? = 0, trailing: CGFloat? = 0) {
    guard let superview = superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    if let top = top {
      topAnchor.constraint(equalTo: safely ? superview.safeAreaLayoutGuide.topAnchor : superview.topAnchor, constant: top).isActive = true
    }
    if let leading = leading {
      leadingAnchor.constraint(equalTo: safely ? superview.safeAreaLayoutGuide.leadingAnchor : superview.leadingAnchor, constant: leading).isActive = true
    }
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: safely ? superview.safeAreaLayoutGuide.bottomAnchor : superview.bottomAnchor, constant: -bottom).isActive = true
    }
    if let trailing = trailing {
      trailingAnchor.constraint(equalTo: safely ? superview.safeAreaLayoutGuide.trailingAnchor : superview.trailingAnchor, constant: -trailing).isActive = true
    }
  }
}
