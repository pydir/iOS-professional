//
//  String+Extensions.swift
//  CoffeeThere
//
//  Created by Oguz Mert Beyoglu on 15.10.2024.
//

import Foundation

extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }
    
    public var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    func isLessThan(_ number: Double) -> Bool {
        if !self.isNumeric {
            return false
        }
        
        guard let value = Double(self) else { return false }
        return value < number
    }
    
    
}
