//
//  HomeViewController.swift
//  Vastra
//
//  Created by Николай Никитин on 21.09.2022.
//

import UIKit
import MapKit

class HomeViewController: BaseViewController {

  //MARK: - Properties
  private var locationManager = LocationManager()

  //MARK: - Subview's
  private lazy var startButton: CircularButton = {
    let button = CircularButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.borderWidth = 15
    button.borderColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    button.titleText = "RUN"
    button.addTarget(self, action: #selector(startRunning), for: .touchUpInside)
    return button
  }()

  private lazy var topLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Vastra"
    label.textAlignment = .center
    label.textColor = .darkGray
    label.font = label.font.withSize(32)
    return label
  }()

  private lazy var mapView: MKMapView = {
    let view = MKMapView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.alpha = 0.6
    view.delegate = self
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
    locationManager.checkLocationAuthorization()
    view.addSubview(topLabel)
    view.addSubview(mapView)
    view.addSubview(startButton)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      topLabel.heightAnchor.constraint(equalToConstant: 50)
    ])

    NSLayoutConstraint.activate([
      mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mapView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
      mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])

    NSLayoutConstraint.activate([
      startButton.widthAnchor.constraint(equalToConstant: 100),
      startButton.heightAnchor.constraint(equalToConstant: 100),
      startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
      startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }

  //MARK: - Actions
  @objc private func startRunning() {

  }
}

//MARK: - MapViewDelegate Delegate Protocol
extension HomeViewController: MKMapViewDelegate {
  func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
  }
}
