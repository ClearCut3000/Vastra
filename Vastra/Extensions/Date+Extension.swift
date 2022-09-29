//
//  Date+Extension.swift
//  Vastra
//
//  Created by Николай Никитин on 29.09.2022.
//

import Foundation

extension Date {
  func getDateString() -> String {
    let calendar = Calendar.current
    let year = calendar.component(.year, from: self)
    let month = calendar.component(.month, from: self)
    let day = calendar.component(.day, from: self)
    return "\(day)/\(month)/\(year)"
  }
}
