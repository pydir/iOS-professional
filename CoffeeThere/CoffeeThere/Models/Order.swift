//
//  Order.swift
//  CoffeeThere
//
//  Created by Oguz Mert Beyoglu on 15.10.2024.
//

import Foundation

struct Order: Codable, Identifiable, Hashable {
    
    var id: Int?
    var name: String
    var coffeeName: String
    var total: Double
    var size: CoffeeSize
}
