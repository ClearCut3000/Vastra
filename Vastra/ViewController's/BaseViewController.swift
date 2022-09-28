//
//  BaseViewController.swift
//  Vastra
//
//  Created by Николай Никитин on 21.09.2022.
//

import UIKit

class BaseViewController: UIViewController {

  //MARK: - Properties
  private lazy var backgroundLayer: GradientView = {
    let view = GradientView(colors: [#colorLiteral(red: 0.9411764706, green: 0.4901960784, blue: 0.9176470588, alpha: 1), #colorLiteral(red: 0.6431372549, green: 0.3764705882, blue: 0.9294117647, alpha: 1), #colorLiteral(red: 0.6235294118, green: 0.7882352941, blue: 0.9529411765, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)])
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
  }

    //MARK: - Methods
  private func setupViews() {
    view.addSubview(backgroundLayer)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      backgroundLayer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      backgroundLayer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      backgroundLayer.topAnchor.constraint(equalTo: view.topAnchor),
      backgroundLayer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}
