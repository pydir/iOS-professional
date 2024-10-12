//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Oguz Mert Beyoglu on 12.10.2024.
//

import XCTest

@testable import Password

// MARK: - Show checkmark or reset when validation is inline section
class PasswordStatusViewTests: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword   = "aA123456!"
    let tooShort        = "1234"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true
    }
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckmarkImage)
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage)
    }
}

// MARK: - Show checkmark or XMark when validation is loss of focus section
class PasswordStatusViewLossOfFocusTests: XCTestCase {
    var statusView: PasswordStatusView!
    let validPassword   = "aA123456!"
    let tooShort        = "1234"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false
    }
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckmarkImage)
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXMarkImage)
    }
}

// MARKL: - Validate Three of Four
class PasswordValidationTests: XCTestCase {
    var statusView: PasswordStatusView!
    let twoOfFour     = "a1234"
    let threeOfFour   = "aA123456"
    let fourOfFour    = "aA123456!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        
    }
    
    func testTwoOfFour() throws {
        XCTAssertFalse(statusView.validate(twoOfFour))
    }
    
    func testThreeOfFour() throws {
        XCTAssertTrue(statusView.validate(threeOfFour))
        
    }
    
    func testFourOfFour() throws {
        XCTAssertTrue(statusView.validate(fourOfFour))
    }
}
