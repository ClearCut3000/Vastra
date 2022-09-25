//
//  CurrentRunViewController.swift
//  Vastra
//
//  Created by Николай Никитин on 23.09.2022.
//

import UIKit
import CoreLocation

class CurrentRunViewController: UIViewController {

  //MARK: - Properties
  private static let titleFontSize: CGFloat = 32
  private static let subtitleFontSize: CGFloat = 24

  private var stattLocation: CLLocation!
  private var endLocation: CLLocation!

  private var runDistance = 0.0
  private var timeElapsed = 0
  private var pace = 0

  private var locationManager = LocationManager()

  private var timer = Timer()

  //MARK: - Subview's
  private lazy var topLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Running..."
    label.font = label.font.withSize(Self.titleFontSize)
    label.textColor = .darkGray
    return label
  }()

  private lazy var timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: Self.subtitleFontSize)
    label.text = "00:00:00"
    return label
  }()

  private lazy var paceTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.text = "Average Pace"
    label.font = label.font.withSize(Self.subtitleFontSize)
    return label
  }()

  private lazy var paceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.text = "0:00"
    label.font = UIFont.boldSystemFont(ofSize: Self.titleFontSize)
    return label
  }()

  private lazy var paceSubtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.text = "/km"
    label.font = label.font.withSize(Self.subtitleFontSize)
    return label
  }()

  private lazy var paceStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [paceTitleLabel, paceLabel, paceSubtitleLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .center
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    return stackView
  }()

  private lazy var distanceTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.text = "Distance"
    label.font = label.font.withSize(Self.subtitleFontSize)
    return label
  }()

  private lazy var distanceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.text = "0.0"
    label.font = UIFont.boldSystemFont(ofSize: Self.titleFontSize)
    return label
  }()

  private lazy var distanceSubtitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.text = "km"
    label.font = label.font.withSize(Self.subtitleFontSize)
    return label
  }()

  private lazy var distanceStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [distanceTitleLabel, distanceLabel, distanceSubtitleLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .center
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    return stackView
  }()

  private lazy var pageStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [timeLabel, paceStackView, distanceStackView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.alignment = .center
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    stackView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    return stackView
  }()

  private lazy var capsuleView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    view.layer.cornerRadius = 35
    view.layer.masksToBounds = true
    return view
  }()

  private lazy var stopSliderKnob: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.isUserInteractionEnabled = true
    imageView.image = UIImage(systemName: "dot.arrowtriangle.up.down.left.circle")
    imageView.tintColor = .white
    imageView.layer.borderColor = UIColor.white.cgColor
    imageView.layer.borderWidth = 5
    imageView.layer.cornerRadius = 25
    imageView.layer.masksToBounds = true
    return imageView
  }()

  private lazy var sliderStop: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(systemName: "stop.circle.fill")
    imageView.tintColor = .white
    imageView.layer.borderColor = UIColor.clear.withAlphaComponent(0.5).cgColor
    imageView.layer.borderWidth = 5
    imageView.layer.cornerRadius = 35
    imageView.layer.masksToBounds = true
    return imageView
  }()

  //MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    locationManager.manager.delegate = self
    startRunning()
  }

  override func viewWillDisappear(_ animated: Bool) {
    stopRun()
    super.viewWillDisappear(animated)
  }

  //MARK: - Methods
  private func setupViews() {

  }

  private func setupConstraints() {

  }

  private func startRunning() {
    locationManager.manager.startUpdatingLocation()
    startTimer()
  }

  private func stopRun() {
    locationManager.manager.stopUpdatingLocation()
    stopTimer()
  }

  private func startTimer() {
    timeLabel.text = timeElapsed.formatTimeString()
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
  }

  private func stopTimer() {}

  @objc private func updateTimer() {}
}

//MARK: -
extension CurrentRunViewController: CLLocationManagerDelegate {

}
