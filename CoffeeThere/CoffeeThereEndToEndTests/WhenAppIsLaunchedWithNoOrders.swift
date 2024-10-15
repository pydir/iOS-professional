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


final class when_updating_an_existing_order: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp()  {
       
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()
        
        // go to the add order screen
        app.buttons["addNewOrderButton"].tap()
        
        // write into textfields
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("John")
        
        coffeeNameTextField.tap()
        coffeeNameTextField.typeText("Hot Coffee")
        
        priceTextField.tap()
        priceTextField.typeText("450")
        
        // place the order
        placeOrderButton.tap()
    }
    
    func test_should_update_order_successfully() {
        
        // go to the order screen
        let orderList = app.collectionViews["orderList"]
        orderList.buttons["orderNameText-coffeeNameAndSizeText-coffeePriceText"].tap()
        
        app.buttons["editOrderButton"].tap()
        
        let nameTextField = app.textFields["name"]
        let coffeeNameTextField = app.textFields["coffeeName"]
        let priceTextField = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        let _ = nameTextField.waitForExistence(timeout: 2.0)
        nameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        nameTextField.typeText("John Edit")
        
        let _ = coffeeNameTextField.waitForExistence(timeout: 2.0)
        coffeeNameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        coffeeNameTextField.typeText("Hot Coffee Edit")
        
        let _ = priceTextField.waitForExistence(timeout: 2.0)
        priceTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
        priceTextField.typeText("150")
        
        placeOrderButton.tap()
        
        XCTAssertEqual("Hot Coffee Edit", app.staticTexts["coffeeNameText"].label)
        
    }
    
    // TEAR DOWN FUNCTIONS RUNS AND THEN DELETE ALL ORDERS FROM THE TEST DATABASE
    override func tearDown() {
        Task {
            guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
            let (_, _) = try! await URLSession.shared.data(from: url)
        }
    }
    
}
