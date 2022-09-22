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
    let view = GradientView(colors: [#colorLiteral(red: 0.3946585059, green: 0.2114059329, blue: 0.5806370378, alpha: 1), #colorLiteral(red: 0.7261916399, green: 0.2106949985, blue: 0.4076785147, alpha: 1), #colorLiteral(red: 0.922157228, green: 0.385228157, blue: 0.2259604931, alpha: 1)])
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
