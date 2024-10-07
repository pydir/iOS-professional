//
//  Decimal+Utils.swift
//  BankUp
//
//  Created by Oguz Mert Beyoglu on 7.10.2024.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
