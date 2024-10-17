//
//  NumberFormatter+Extensions.swift
//  BudgetApp
//
//  Created by Oguz Mert Beyoglu on 16.10.2024.
//

import Foundation

extension NumberFormatter {
    
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
}
