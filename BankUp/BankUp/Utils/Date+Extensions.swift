//
//  Date+Extensions.swift
//  BankUp
//
//  Created by Oguz Mert Beyoglu on 9.10.2024.
//

import Foundation

extension Date {
    static var bankUpDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankUpDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
