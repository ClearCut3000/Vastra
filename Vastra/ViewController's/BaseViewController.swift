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
    let view = GradientView(colors: [#colorLiteral(red: 0.6, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.3568627451, blue: 0, alpha: 1), #colorLiteral(red: 0.831372549, green: 0.8509803922, blue: 0.1450980392, alpha: 1), #colorLiteral(red: 1, green: 0.9333333333, blue: 0.3882352941, alpha: 1)])
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
