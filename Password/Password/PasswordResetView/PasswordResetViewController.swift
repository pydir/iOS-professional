//
//  ViewController.swift
//  Password
//
//  Created by Oguz Mert Beyoglu on 10.10.2024.
//

import UIKit

class PasswordResetViewController: UIViewController {
    let passwordTextField           = PasswordTextField(placeHolderText: "New password")
    let confirmPasswordTextField    = PasswordTextField(placeHolderText: "Re-enter new password")
    
    let stackView           = UIStackView()
    let statusView          = PasswordStatusView()
    let resetButton         = UIButton(type: .custom)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension PasswordResetViewController {
    private func style() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.delegate = self
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis    = .vertical
        stackView.spacing = 20
    
        statusView.translatesAutoresizingMaskIntoConstraints                = false

        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints  = false
        confirmPasswordTextField.delegate = self
        
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
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
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
}
