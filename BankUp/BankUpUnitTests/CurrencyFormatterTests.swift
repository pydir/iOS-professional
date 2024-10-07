//
//  CurrencyFormatterTests.swift
//  BankUpUnitTests
//
//  Created by Oguz Mert Beyoglu on 7.10.2024.
//

import Foundation

import XCTest

@testable import BankUp

class Test: XCTestCase {
    var formatter: CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929.466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929466)
        XCTAssertEqual(result, "₺929.466,00")
    }
    
    func testZeroDollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0)
        XCTAssertEqual(result, "₺0,00")
    }
    
    func testDollarsFormattedWıthCurrencySymbol() throws {
        let locale          = Locale.current
        let currencySymbol  = locale.currencySymbol!
        
        let result = formatter.dollarsFormatted(929466.23)
        XCTAssertEqual(result, "\(currencySymbol)929.466,23")
    }
    
}
