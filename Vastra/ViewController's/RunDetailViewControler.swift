//
//  RunDetailViewControler.swift
//  Vastra
//
//  Created by Николай Никитин on 01.10.2022.
//

import UIKit
import MapKit

final class RunDetailViewControler: BaseViewController {

  //MARK: - Properties
  var run: Run

//MARK: - Subview's
  private lazy var mapView: MKMapView = {
    let mapView = MKMapView()
    mapView.translatesAutoresizingMaskIntoConstraints = false
    mapView.alpha = 0.6
    mapView.delegate = self
    return mapView
  }()

  private lazy var topHandleBackground: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    return view
  }()

  private lazy var topHandle: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.white.withAlphaComponent(0.6)
    view.layer.cornerRadius = 3
    view.layer.masksToBounds = true
    return view
  }()

  //MARK: - Init's
  init(run: Run) {
    self.run = run
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }

  //MARK: - Methods
  private func setupViews() {}

  private func setupConstraints() {}
}
