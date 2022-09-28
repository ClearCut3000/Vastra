//
//  TabBarViewController.swift
//  Vastra
//
//  Created by Николай Никитин on 21.09.2022.
//

import UIKit

final class TabBarViewController: UITabBarController {
  
  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    tabBar.tintColor = UIColor.label
    setupViewController()
  }
  
  //MARK: - Methods
  private func setupViewController() {
    viewControllers = [
      createViewControllers(for: HomeViewController(), title: "Run", systemImage: "hare"),
      createViewControllers(for: HistoryViewController(), title: "Logs", systemImage: "clock")
    ]
  }
  
  private func createViewControllers(for viewController: UIViewController, title: String, systemImage: String) -> UIViewController {
    let iconSymbol = UIImage(systemName: systemImage)
    let selectedSymbol = UIImage(systemName: systemImage,
                                 withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
    let tabBarItem = UITabBarItem(title: title,
                                  image: iconSymbol,
                                  selectedImage: selectedSymbol)
    viewController.tabBarItem = tabBarItem
    return viewController
  }
}
