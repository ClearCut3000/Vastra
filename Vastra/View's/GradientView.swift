//
//  GradientView.swift
//  Vastra
//
//  Created by Николай Никитин on 21.09.2022.
//

import UIKit

final class GradientView: UIView {

  // MARK: - Init's
  init(colors:[UIColor]) {
    super.init(frame: .zero)
    let gradientLayer = layer as! CAGradientLayer
    /// Convert colors to cgColor type
    gradientLayer.colors = colors.map { $0.cgColor }
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 1, y: 1)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override class var layerClass: AnyClass {
    return CAGradientLayer.classForCoder()
  }
}
