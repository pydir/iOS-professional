//
//  CoffeeThereEndToEndTests.swift
//  CoffeeThereEndToEndTests
//
//  Created by Oguz Mert Beyoglu on 15.10.2024.
//

import XCTest

final class WhenAddingANewCoffeeOrder: XCTestCase {
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        app.buttons["addNewOrderButton"].tap()
        
        let nameTextField       = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField      = app.textFields["price"]
        let placeOrderButton    = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Mehmet")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Cartado")
        
        priceTextField.tap()
        priceTextField.typeText("54")
        placeOrderButton.tap()
    }
    
    func testShouldDisplayCoffeeOrderInListWhenSuccess() throws {
        XCTAssertEqual("Mehmet", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Cartado (Medium)", app.staticTexts["coffeeNameAndSizeText"].label)
        XCTAssertEqual("₺54,00", app.staticTexts["coffeePriceText"].label)
    }
    
    /// called after running each test
    override func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
            let (_,_) = try! await URLSession.shared.data(from: url)
        }
    }
}

final class WhenAppIsLaunchedWithNoOrders: XCTestCase {
    @MainActor
    func testNoOrderMessageDisplayed() throws {
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        XCTAssertEqual("No orders found!", app.staticTexts["noOrdersText"].label)
    }
}


final class DeletingAnOrder: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        app.buttons["addNewOrderButton"].tap()
        
        let nameTextField       = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField      = app.textFields["price"]
        let placeOrderButton    = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("Mehmet")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Cartado")
        
        priceTextField.tap()
        priceTextField.typeText("54")
        placeOrderButton.tap()
    }
    
    
    @MainActor
    func testDeleteTheOrderSuccessState() throws {
        let collectionsViewQuery = XCUIApplication().collectionViews
        let cellsQuery = collectionsViewQuery.cells
        
        let element = cellsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element
        element.swipeLeft()
        
        collectionsViewQuery.buttons["Delete"].tap()
        
        let orderList = app.collectionViews["orderList"]
        
        XCTAssertEqual(0, orderList.cells.count)    
    }
    
    /// called after running each test
    override func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
            let (_,_) = try! await URLSession.shared.data(from: url)
        }
    }
}
