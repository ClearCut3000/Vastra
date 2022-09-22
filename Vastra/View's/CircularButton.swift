//
//  CircularButton.swift
//  Vastra
//
//  Created by Николай Никитин on 22.09.2022.
//

import UIKit

final class CircularButto: UIButton {

  //MARK: - Properties
  var borderWidth: CGFloat = 10.0
  var borderColor: UIColor = UIColor.white

  var titleText: String? {
    didSet {
      setTitle(titleText, for: .normal)
    }
  }

  var titleTextColor: UIColor? {
    didSet {
      setTitleColor(titleTextColor, for: .normal)
    }
  }

  //MARK: - Init's
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Layout
  override func layoutSubviews() {
    super.layoutSubviews()
    setup()
  }

  //MARK: - Methods
  private func setup() {
    clipsToBounds = true
    backgroundColor = UIColor.purple
    layer.cornerRadius = frame.size.width / 2.0
    layer.borderColor = borderColor.cgColor
    layer.borderWidth = borderWidth
  }
}
