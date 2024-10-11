//
//  PasswordCriteria.swift
//  Password
//
//  Created by Oguz Mert Beyoglu on 11.10.2024.
//

import Foundation

struct PasswordCriteria {
    private static func lengthCriteriaMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }
    
    private static func noSpaceCriteriaMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    
    static func lengthAndNoSpaceMet(_ text: String) -> Bool {
        lengthCriteriaMet(text) && noSpaceCriteriaMet(text)
    }
    
    static func uppercaseMet(_ text: String) -> Bool {
        text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    
    static func lowercaseMet(_ text: String) -> Bool {
        text.range(of: "[a-z]+", options: .regularExpression) != nil
    }
    
    static func digitMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.decimalDigits) != nil
    }
    
    static func specialCharacterMet(_ text: String) -> Bool {
        text.range(of: "[@:?!()$#,./\\\\]+", options: .regularExpression) != nil
    }
 
    
}
