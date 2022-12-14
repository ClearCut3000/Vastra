//
//  CurrentRunViewController.swift
//  Vastra
//
//  Created by Николай Никитин on 23.09.2022.
//

import UIKit
import CoreLocation
import RealmSwift

class CurrentRunViewController: BaseViewController {

  //MARK: - Properties
  private static let titleFontSize: CGFloat = 32
  private static let subtitleFontSize: CGFloat = 24

  private var startLocation: CLLocation!
  private var endLocation: CLLocation!

  private var runDistance = 0.0
  private var timeElapsed = 0
  private var pace = 0
  fileprivate var coordLocations = List<Location>()

  private var locationManager = LocationManager()

  private var timer = Timer()

  //MARK: - Subview's
  private lazy var topLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Running..."
    label.textAlignment = .center
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

  private lazy var sliderView: UIView = {
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
    imageView.image = UIImage(systemName: "arrow.left.and.right.circle")
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
    imageView.image = UIImage(systemName: "stop.circle.fill",
                              withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white, .systemRed]))
    imageView.tintColor = .white
    imageView.layer.borderColor = UIColor.clear.withAlphaComponent(0.5).cgColor
    imageView.layer.borderWidth = 5
    imageView.layer.cornerRadius = 35
    imageView.layer.masksToBounds = true
    return imageView
  }()

  private lazy var sliderText: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Slide to stop"
    label.textColor = UIColor(white: 1, alpha: 1)
    label.font = label.font.withSize(Self.subtitleFontSize)
    return label
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
    sliderText.startShimmeringAnimation()
    sliderBounceAnimation()
  }

  override func viewWillDisappear(_ animated: Bool) {
    stopRun()
    super.viewWillDisappear(animated)
  }

  //MARK: - Methods
  private func setupViews() {
    view.addSubview(topLabel)
    view.addSubview(pageStackView)
    view.addSubview(sliderView)
    sliderView.addSubview(stopSliderKnob)
    sliderView.addSubview(sliderStop)
    sliderView.addSubview(sliderText)

    let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissEnd(sender:)))
    stopSliderKnob.addGestureRecognizer(swipeGesture)

  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      topLabel.heightAnchor.constraint(equalToConstant: 50)
    ])

    NSLayoutConstraint.activate([
      pageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      pageStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      pageStackView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8)
    ])

    NSLayoutConstraint.activate([
      sliderView.widthAnchor.constraint(equalToConstant: 300),
      sliderView.heightAnchor.constraint(equalToConstant: 70),
      sliderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      sliderView.topAnchor.constraint(equalTo: pageStackView.bottomAnchor, constant: 8),
      sliderView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])

    NSLayoutConstraint.activate([
      stopSliderKnob.leadingAnchor.constraint(equalTo: sliderView.leadingAnchor, constant: 8),
      stopSliderKnob.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor),
      stopSliderKnob.widthAnchor.constraint(equalToConstant: 50),
      stopSliderKnob.heightAnchor.constraint(equalToConstant: 50)
    ])

    NSLayoutConstraint.activate([
      sliderStop.trailingAnchor.constraint(equalTo: sliderView.trailingAnchor),
      sliderStop.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor),
      sliderStop.heightAnchor.constraint(equalToConstant: 70),
      sliderStop.widthAnchor.constraint(equalToConstant: 70)
    ])

    NSLayoutConstraint.activate([
      sliderText.centerXAnchor.constraint(equalTo: sliderView.centerXAnchor),
      sliderText.centerYAnchor.constraint(equalTo: sliderView.centerYAnchor)
    ])
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
    RunLoop.current.add(timer, forMode: .common)
    timer.tolerance = 0.1
  }

  private func stopTimer() {
    timer.invalidate()
    timeElapsed = 0
  }

  private func computePace(time seconds: Int, kilometers: Double) -> String {
    pace = Int(Double(seconds) / kilometers)
    return pace.formatTimeString()
  }

  private func sliderBounceAnimation() {
    UIView.animate(withDuration: 0.5) {
      self.stopSliderKnob.center.x += 100
    } completion: { _ in
      UIView.animate(withDuration: 1,
                     delay: 0.1,
                     usingSpringWithDamping: 0.5,
                     initialSpringVelocity: 0.1,
                     options: .curveEaseInOut) {
        self.stopSliderKnob.center.x -= 100
      } completion: { _ in }
    }
  }

  @objc private func updateTimer() {
    timeElapsed += 1
    timeLabel.text = timeElapsed.formatTimeString()
  }

  @objc private func dismissEnd(sender: UIPanGestureRecognizer) {
    let adjust: CGFloat = 35
    let translation = sender.translation(in: view)

    if sender.state == .began || sender.state == .changed {
      if stopSliderKnob.center.x > sliderStop.center.x {
        stopSliderKnob.center.x = sliderStop.center.x
        let timeElapsed = self.timeElapsed
        stopRun()
        Run.addRunToRealm(pace: pace,
                          distance: runDistance,
                          duration: timeElapsed,
                          locations: coordLocations)
        dismiss(animated: true)
      } else if stopSliderKnob.center.x < sliderView.bounds.minX + adjust {
        stopSliderKnob.center.x = sliderView.bounds.minX + adjust
      } else {
        stopSliderKnob.center.x += translation.x
      }
      sender.setTranslation(.zero, in: view)
    } else if sender.state == .ended && stopSliderKnob.center.x < sliderStop.center.x {
      /// if sliderKnob center not collided with sliderStop center
      UIView.animate(withDuration: 0.5) {
        /// brings view back to intial value points
        self.stopSliderKnob.center.x = self.sliderView.bounds.minX + adjust
      }
    }
  }
}

//MARK: - CLLocationManagerDelegate Protocol
extension CurrentRunViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if startLocation == nil {
      startLocation = locations.first
    } else if let location = locations.last {
      runDistance += endLocation.distance(from: location)
      let newLocation = Location(latitude: Double(endLocation.coordinate.latitude),
                                 longitude: Double(endLocation.coordinate.longitude))
      coordLocations.insert(newLocation, at: 0)
      self.distanceLabel.text = self.runDistance.meterToKilomerers().toString(places: 2)
      if timeElapsed > 0 && runDistance > 0 {
        paceLabel.text = computePace(time: timeElapsed, kilometers: runDistance.meterToKilomerers())
      }
    }
    endLocation = locations.last
  }
}
