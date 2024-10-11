//
//  ViewController.swift
//  Password
//
//  Created by Oguz Mert Beyoglu on 10.10.2024.
//

import UIKit

class PasswordResetViewController: UIViewController {
    
    typealias CustomValidation = PasswordTextField.CustomValidation
    
    let passwordTextField           = PasswordTextField(placeHolderText: "New password")
    let confirmPasswordTextField    = PasswordTextField(placeHolderText: "Re-enter new password")
    
    let stackView           = UIStackView()
    let statusView          = PasswordStatusView()
    let resetButton         = UIButton(type: .custom)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
    }
}

extension PasswordResetViewController {
    private func setup() {
        setupNewPassword()
        setupConfirmPassword()
        setupDismissKeyboardGesture()
    }
    
    private func setupNewPassword() {
        let newPasswordValidation: CustomValidation = { text in
            
            // empty text string
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }
            
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.@:?!()$\\$"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars: (,.@:?!()$\\$) with no spaces")
            }
            
//             creteria met
            self.statusView.updateDisplay(text)
            if !self.statusView.validate(text) {
                return (false, "Your password must meet the requirements below")
            }
            
            return (true, "")
        }
        passwordTextField.customValidation  = newPasswordValidation
        passwordTextField.delegate          = self
    }
    
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }
            
            guard text == self.passwordTextField.text else {
                return (false, "Passwords doesn't match.")
            }
            
            return (true, "")
        }
        
        confirmPasswordTextField.customValidation   = confirmPasswordValidation
        confirmPasswordTextField.delegate           = self
    }
    
    private func style() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis    = .vertical
        stackView.spacing = 20
    
        statusView.translatesAutoresizingMaskIntoConstraints                = false

        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints  = false
        
        resetButton.translatesAutoresizingMaskIntoConstraints               = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
    }
    
    private func layout() {
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)

        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 2),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

// MARK: - Gestures
extension PasswordResetViewController {
    private func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc private func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: - Actions
extension PasswordResetViewController {
    @objc private func resetPasswordButtonTapped(_ sender: UIButton) {
        
    }
}

// MARK: - PasswordTextFieldDelegate
extension PasswordResetViewController: PasswordTextFieldDelegate {
    func editingChanged(_ sender: PasswordTextField) {
        if sender === passwordTextField {
            statusView.updateDisplay(sender.passwordTextField.text ?? "")
        }
        
    }
    
    func editingDidEnd(_ sender: PasswordTextField) {
        if sender === passwordTextField {
            statusView.shouldResetCriteria = false
            _ = passwordTextField.validate()
        } else if sender === confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
}

