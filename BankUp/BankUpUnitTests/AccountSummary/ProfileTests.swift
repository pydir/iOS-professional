//
//  ProfileTests.swift
//  BankUpUnitTests
//
//  Created by Oguz Mert Beyoglu on 9.10.2024.
//

import Foundation
import XCTest

@testable import BankUp

class ProfileTests: XCTestCase {
    override class func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws {
        let json = """
        {
            "id": "1",
            "first_name": "Mert",
            "last_name": "Beyoglu",
        }
        """
        
        let data = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(Profile.self, from: data)
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Mert")
        XCTAssertEqual(result.lastName, "Beyoglu")
    }
}
