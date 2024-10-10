//
//  ViewController.swift
//  Password
//
//  Created by Oguz Mert Beyoglu on 10.10.2024.
//

import UIKit

class PasswordResetViewController: UIViewController {
    let passwordResetView   = PasswordResetView()
    let stackView           = UIStackView()
    
    let criteriaView        = PasswordCriteriaView(text: "uppercase letter (A-Z")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension PasswordResetViewController {
    private func style() {
        passwordResetView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis    = .vertical
        stackView.spacing = 20
        
        criteriaView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
//        stackView.addArrangedSubview(passwordResetView)
        stackView.addArrangedSubview(criteriaView)
        
        view.addSubview(stackView)
        
//        NSLayoutConstraint.activate([
//            passwordResetView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: passwordResetView.trailingAnchor, multiplier: 1),
//            passwordResetView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        ])
        
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
        ])
        
        
        
    }
}

