//
//  Double+Extension.swift
//  Vastra
//
//  Created by Николай Никитин on 26.09.2022.
//

import Foundation

extension Double {
  func meterToKilomerers() -> Double {
    let meters = Measurement(value: self, unit: UnitLength.miles)
    return meters.converted(to: .kilometers).value
  }

  func toString(places: Int) -> String {
    return String(format: "%.\(places)f", self)
  }
}
