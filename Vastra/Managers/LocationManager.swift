//
//  LocationManager.swift
//  Vastra
//
//  Created by Николай Никитин on 22.09.2022.
//

import Foundation
import CoreLocation

final class LocationManager {

  var manager: CLLocationManager

  /// Init with configuring location settings for fitness and best accurancy
  init() {
    manager = CLLocationManager()
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.activityType = .fitness
  }

  ///Authorazation checking and request
  func checkLocationAuthorization() {
    if manager.authorizationStatus != .authorizedWhenInUse {
      manager.requestWhenInUseAuthorization()
    }
  }
}
