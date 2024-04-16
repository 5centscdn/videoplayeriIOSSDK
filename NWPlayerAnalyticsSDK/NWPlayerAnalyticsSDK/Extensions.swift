//
//  Extensions.swift
//  VideoPlayerAnalytics
//
//  Created by Mamun Ar Rashid on 8/7/23.
//

import Foundation

extension Double {
  func roundToDecimal(_ fractionDigits: Int) -> Double {
    let multiplier = pow(10, Double(fractionDigits))
    return Darwin.round(self * multiplier) / multiplier
  }
  
  func toString() -> String {
    return String(describing: self)
  }
}
