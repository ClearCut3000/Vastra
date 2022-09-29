//
//  Location.swift
//  Vastra
//
//  Created by Николай Никитин on 28.09.2022.
//

import Foundation
import RealmSwift

final class Location: Object {
  @objc dynamic public private(set) var latitude = 0.0
  @objc dynamic public private(set) var longitude = 0.0

  convenience init(latitude: Double, longitude: Double) {
    self.init()
    self.longitude = longitude
    self.latitude = latitude
  }
}
