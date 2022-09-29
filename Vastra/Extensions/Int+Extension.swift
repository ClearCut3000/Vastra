//
//  Int+Extension.swift
//  Vastra
//
//  Created by Николай Никитин on 25.09.2022.
//

import Foundation

extension Int {
  func formatTimeString() -> String {
    let hours = self / 3600
    let minutes = (self % 3600) / 60
    let seconds = (self % 3600) % 60
    if seconds < 0 {
      return "00:00:00"
    } else {
      if hours == 0 {
        return String(format: "%02d:%02d", minutes, seconds)
      } else {
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
      }
    }
  }
}
