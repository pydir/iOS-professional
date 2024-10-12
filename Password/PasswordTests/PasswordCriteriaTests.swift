//
//  PasswordCriteriaTests.swift
//  PasswordTests
//
//  Created by Oguz Mert Beyoglu on 12.10.2024.
//

import XCTest

@testable import Password

class PasswordLengthCriteriaTests: XCTestCase {
    func testShort() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("1234"))
    }
    
    func testLong() throws {
        XCTAssertFalse(PasswordCriteria.lengthCriteriaMet("123412341234123412341234123412341"))
    }
    
    func testValidShort() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12345678"))
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("123456787457845"))
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("123456783243"))
    }
    
    func testValidLong() throws {
        XCTAssertTrue(PasswordCriteria.lengthCriteriaMet("12341234123412341234123412341234"))
    }
}

class PasswordSpaceCriteriaTests: XCTestCase {
    func testNoSpace() throws {
        XCTAssertFalse(PasswordCriteria.noSpaceCriteriaMet("with space"))
    }
    
    func testValidNoSpace() throws {
        XCTAssertTrue(PasswordCriteria.noSpaceCriteriaMet("witout_space"))
    }
}

class PasswordUppercaseCriteriaTests: XCTestCase {
    func testUppercase() throws {
        XCTAssertFalse(PasswordCriteria.uppercaseMet("no_uppercase"))
    }
    
    func testValidUppercase() throws {
        XCTAssertTrue(PasswordCriteria.uppercaseMet("withUppercase"))
    }
}

class PasswordLowercaseCriteriaTestsTests: XCTestCase {
    func testLowercase() throws {
        XCTAssertFalse(PasswordCriteria.lowercaseMet("NO_LOWERCASE"))
    }
    
    func testValidLowercase() throws {
        XCTAssertTrue(PasswordCriteria.lowercaseMet("With_Lowercase"))
    }
}

class PasswordDigitCriteriaTests: XCTestCase {
    func testDigit() throws {
        XCTAssertFalse(PasswordCriteria.digitMet("no_digit"))
    }
    
    func testValidDigit() throws {
        XCTAssertTrue(PasswordCriteria.digitMet("with_digit_1"))
    }
}

class PasswordSpecialCharacterCriteriaTests: XCTestCase {
    func testSpecialCharacter() throws {
        XCTAssertFalse(PasswordCriteria.specialCharacterMet("noSpecialCharacters"))
    }
    
    func testValidSpecialCharacter() throws { //      for this characters  @:?!()$#,./\
        XCTAssertTrue(PasswordCriteria.specialCharacterMet("with_special@character_set./!"))
    }
}
