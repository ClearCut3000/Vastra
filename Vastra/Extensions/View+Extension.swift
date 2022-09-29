//
//  View+Extension.swift
//  Vastra
//
//  Created by Николай Никитин on 29.09.2022.
//

import UIKit

extension UIView {

  func startShimmeringAnimation() {
    // Create color
    let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
    let blackColor = UIColor.black.withAlphaComponent(0.5).cgColor

    // Create a CAGradientLayer
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [blackColor, lightColor, blackColor]
    gradientLayer.frame = CGRect(x: -self.bounds.size.width,
                                 y: -self.bounds.size.height,
                                 width: 3 * self.bounds.size.width,
                                 height: 3 * self.bounds.size.height)
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradientLayer.locations =  [0.35, 0.50, 0.65]
    self.layer.mask = gradientLayer

    // Add animation over gradient Layer
    CATransaction.begin()
    let animation = CABasicAnimation(keyPath: "locations")
    animation.fromValue = [0.0, 0.1, 0.2]
    animation.toValue = [0.8, 0.9, 1.0]
    animation.duration = 2
    animation.repeatCount = .infinity
    CATransaction.setCompletionBlock { [weak self] in
      guard let self = self else { return }
      self.layer.mask = nil
    }
    gradientLayer.add(animation, forKey: "shimmerAnimation")
    CATransaction.commit()
  }
}


