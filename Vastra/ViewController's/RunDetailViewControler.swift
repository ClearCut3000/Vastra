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
    setMapOverlay()
  }

  //MARK: - Methods
  private func setupViews() {
    view.addSubview(mapView)
    view.addSubview(topHandleBackground)
    topHandleBackground.addSubview(topHandle)
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      mapView.topAnchor.constraint(equalTo: view.topAnchor),
      mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    NSLayoutConstraint.activate([
      topHandleBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      topHandleBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      topHandleBackground.topAnchor.constraint(equalTo: view.topAnchor),
      topHandleBackground.heightAnchor.constraint(equalToConstant: 20)
    ])

    NSLayoutConstraint.activate([
      topHandle.widthAnchor.constraint(equalToConstant: 100),
      topHandle.heightAnchor.constraint(equalToConstant: 6),
      topHandle.centerXAnchor.constraint(equalTo: topHandleBackground.centerXAnchor),
      topHandle.centerYAnchor.constraint(equalTo: topHandleBackground.centerYAnchor)
    ])
  }

  /// Makes overlay with start and finish map point annotations, marked as Start and Finish
  private func setMapOverlay() {
    if mapView.overlays.count > 0 {
      mapView.removeOverlays(mapView.overlays)
    }
    mapView.addOverlay(getPolyline(from: run))
    mapView.setRegion(centerMap(run: run), animated: true)

    let startPoint = MKPointAnnotation()
    startPoint.title = "Start"
    let startLocation = run.locations[run.locations.count - 1]
    startPoint.coordinate = CLLocationCoordinate2D(latitude: startLocation.latitude, longitude: startLocation.longitude)
    mapView.addAnnotation(startPoint)

    let finishPoint = MKPointAnnotation()
    finishPoint.title = "Finish"
    let finishLocation = run.locations[0]
    finishPoint.coordinate = CLLocationCoordinate2D(latitude: finishLocation.latitude, longitude: finishLocation.longitude)
    mapView.addAnnotation(finishPoint)
  }

  /// Creates polylane from run.locations on mapView
  private func getPolyline(from run: Run) -> MKPolyline {
    var coordinates = [CLLocationCoordinate2D]()
    for location in run.locations {
      coordinates.append(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
    }
    return MKPolyline(coordinates: coordinates, count: run.locations.count)
  }

  private func centerMap(run: Run) -> MKCoordinateRegion {
    guard let (minLocation, maxLocation) = getMinMaxLocationCoordinates(run: run) else {
      return MKCoordinateRegion()
    }
    return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLocation.latitude + maxLocation.latitude) / 2,
                                                             longitude: (minLocation.longitude + maxLocation.longitude) / 2),
                              span: MKCoordinateSpan(latitudeDelta: (maxLocation.latitude - minLocation.latitude) * 1.5,
                                                     longitudeDelta: (maxLocation.longitude - minLocation.longitude) * 1.5))
  }

  private func getMinMaxLocationCoordinates(run: Run) -> (min: CLLocationCoordinate2D, max: CLLocationCoordinate2D)? {
    let locations = run.locations
    guard let firstLocation = locations.first else {
      return nil
    }
    var minLatitude = firstLocation.latitude
    var minLongitude = firstLocation.longitude

    var maxLatitude = minLatitude
    var maxLongitude = minLongitude

    for location in locations {
      minLatitude = min(minLatitude, location.latitude)
      minLongitude = min(minLongitude, location.longitude)

      maxLatitude = max(maxLatitude, location.latitude)
      maxLongitude = max(maxLongitude, location.longitude)
    }
    return (min: CLLocationCoordinate2D(latitude: minLatitude, longitude: minLongitude),
            max: CLLocationCoordinate2D(latitude: maxLatitude, longitude: maxLongitude))
  }
}

//MARK: - MapViewDelegate Protocol
extension RunDetailViewControler: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let polyLine = overlay as! MKPolyline
    let renderer = MKPolylineRenderer(polyline: polyLine)
    renderer.strokeColor = UIColor.blue
    renderer.lineWidth = 4
    return renderer
  }

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is MKPointAnnotation else { return nil }
    let identifier = "mapAnnotation"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = true
    } else {
      annotationView!.annotation = annotation
    }

    if annotation.title == "Start" {
      annotationView!.pinTintColor = UIColor.red
    } else if annotation.title == "Finish" {
      annotationView!.pinTintColor = UIColor.green
    }
    return annotationView
  }
}
