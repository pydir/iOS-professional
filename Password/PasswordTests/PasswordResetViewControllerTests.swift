//
//  PasswordResetViewControllerTests.swift
//  PasswordTests
//
//  Created by Oguz Mert Beyoglu on 12.10.2024.
//

import XCTest

@testable import Password

// MARK: - New Password Validation
class PasswordResetViewControllerTests: XCTestCase {
    var viewController: PasswordResetViewController!
    let validPassword           = "ValidPassword1@"
    let invalidPassword         = "invalid+password"
    let criteriaNotMetPassword  = "criteriaNotMet"
    
    override func setUp() {
        super.setUp()
        viewController = PasswordResetViewController()
    }
    
    func testEmptyPasswords() throws {
        viewController.newPasswordText = ""
        viewController.resetPasswordButtonTapped(UIButton())
        
        XCTAssertEqual(viewController.passwordTextField.errorLabel.text!, "Enter your password")
    }
    
    func testInvalidPassword() throws {
        viewController.newPasswordText      = invalidPassword
        viewController.resetPasswordButtonTapped(UIButton())
        
        XCTAssertEqual(viewController.passwordTextField.errorLabel.text!, "Enter valid special chars: (,.@:?!()$\\$) with no spaces")
    }
    
    func testValidPassword() throws {
        viewController.newPasswordText      = validPassword
        viewController.confirmPasswordText  = validPassword
        viewController.resetPasswordButtonTapped(UIButton())
        
        XCTAssertEqual(viewController.passwordTextField.errorLabel.text!, "")
        XCTAssertEqual(viewController.confirmPasswordTextField.errorLabel.text!, "")
    }
    
    func testCriteriaNotMet() throws {
        viewController.newPasswordText      = criteriaNotMetPassword
        
        viewController.resetPasswordButtonTapped(UIButton())
        XCTAssertEqual(viewController.passwordTextField.errorLabel.text!, "Your password must meet the requirements below")
    }
}


// MARK: - Confirm Password Validation Case
class PasswordResetViewController_ConfirmPasswordTests: XCTestCase {
    var viewController: PasswordResetViewController!
    let validPassword       = "ValidPassword1@"
    let tooShortPassword    = "tooShort"
    
    override func setUp() {
        super.setUp()
        viewController = PasswordResetViewController()
    }
    
    func testEmptyPassword() throws {
        viewController.confirmPasswordText = ""
        viewController.resetPasswordButtonTapped(UIButton())
        
        XCTAssertEqual(viewController.confirmPasswordTextField.errorLabel.text!, "Enter your password")
    }
    
    func testDoNotMatch() throws {
        viewController.newPasswordText     = validPassword
        viewController.confirmPasswordText = tooShortPassword
        viewController.resetPasswordButtonTapped(UIButton())
        
        XCTAssertEqual(viewController.confirmPasswordTextField.errorLabel.text!, "Passwords doesn't match.")
        
    }
    
    func testPasswordMatch() throws {
        viewController.newPasswordText     = validPassword
        viewController.confirmPasswordText = validPassword
        
        viewController.resetPasswordButtonTapped(UIButton())
        XCTAssertEqual(viewController.confirmPasswordTextField.errorLabel.text!, "")
    }
}

class PasswordResetViewController_ShowAlertTests: XCTestCase {
    var viewController: PasswordResetViewController!
    let validPassword    = "aA123456!"
    let tooShortPassword = "tooShort"
    
    override func setUp() {
        super.setUp()
        viewController = PasswordResetViewController()
    }
    
    private func testShowSuccess() throws {
        viewController.newPasswordText      = validPassword
        viewController.confirmPasswordText  = validPassword
        viewController.resetPasswordButtonTapped(UIButton())
        
        
        XCTAssertNotNil(viewController.alert)
        XCTAssertEqual(viewController.alert!.title, "Success")
        XCTAssertEqual(viewController.alert!.message, "You have succesfully changed the password")
    }
    
    private func testShowFailed() throws {
        viewController.newPasswordText = tooShortPassword
        XCTAssertNil(viewController.alert)
    }
}
