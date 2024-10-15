//
//  CoffeSize.swift
//  CoffeeThere
//
//  Created by Oguz Mert Beyoglu on 15.10.2024.
//

import Foundation

enum CoffeeSize: String, Codable, CaseIterable {
    case small  = "Small"
    case medium = "Medium"
    case large  = "Large"
}

enum CoffeeOrderError: Error {
    case invalidOrderID
}

