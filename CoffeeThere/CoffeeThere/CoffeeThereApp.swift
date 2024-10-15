//
//  CoffeeThereApp.swift
//  CoffeeThere
//
//  Created by Oguz Mert Beyoglu on 15.10.2024.
//

import SwiftUI

@main
struct CoffeeThereApp: App {
    
    @StateObject private var model: CoffeeModel
    
    init() {
        var configuration  = Configuration()
        let webService = WebService(baseURL: configuration.environment.baseURL)
        _model = StateObject(wrappedValue: CoffeeModel(webservice: webService))
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
