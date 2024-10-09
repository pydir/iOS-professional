//
//  AccountTests.swift
//  BankUpUnitTests
//
//  Created by Oguz Mert Beyoglu on 9.10.2024.
//

import Foundation
import XCTest

@testable import BankUp

class AccountTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
            [
                {
                    "id": "1",
                    "type": "CreditCard",
                    "name": "Basic Savings",
                    "amount": 123456.89,
                    "createdDateTime": "2010-06-21T15:29:32Z"
                },
                {
                    "id": "2",
                    "type": "Banking",
                    "name": "No-Fee",
                    "amount": 17562.44,
                    "createdDateTime": "2010-06-21T15:29:32Z"
                },
            ]
        """
        
        print(json)
        
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .iso8601
        let accounts = try decoder.decode([Account].self, from: data)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        XCTAssertEqual(accounts.count, 2)
        
        XCTAssertEqual(accounts[1].id, "2")
        XCTAssertEqual(accounts[1].type, AccountType.Banking)
        XCTAssertEqual(accounts[1].amount, 17562.44)
        XCTAssertEqual(accounts[1].createdDateTime.monthDayYearString, "Jun 21, 2010")
        
        XCTAssertEqual(accounts[0].id, "1")
        XCTAssertEqual(accounts[0].type, AccountType.CreditCard)
        XCTAssertEqual(accounts[0].amount, 123456.89)
        XCTAssertEqual(accounts[0].createdDateTime.monthDayYearString, "Jun 21, 2010")
        
    }
}
