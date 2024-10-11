//
//  PasswordResetView.swift
//  Password
//
//  Created by Oguz Mert Beyoglu on 10.10.2024.
//

import Foundation
import UIKit

class PasswordTextField: UIView {
    let lockImageView       = UIImageView()
    let passwordTextField   = UITextField()
    let toggleButton        = UIButton(type: .custom)
    let dividerView         = UIView()
    let errorLabel          = UILabel()
    let placeHolderText: String
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
    }
    
}

extension PasswordTextField {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        lockImageView.translatesAutoresizingMaskIntoConstraints     = false
        let lockImage = UIImage(systemName: "lock.fill")
        lockImageView.image = lockImage
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        passwordTextField.keyboardType      = .asciiCapable
        passwordTextField.placeholder       = placeHolderText
        
        toggleButton.translatesAutoresizingMaskIntoConstraints      = false
        toggleButton.addTarget(self, action: #selector(handleToggleButtonAction(_:forEvent:)), for: [.touchDown, .touchUpInside, .touchUpOutside])
        let visibleEyeImage = UIImage(systemName: "eye.fill")
        toggleButton.setImage(visibleEyeImage, for: [])
        
        
        // content compression fix
        toggleButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        passwordTextField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .separator
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = "Your password must meet requires below"
        errorLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        errorLabel.textColor = .systemRed
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
//        errorLabel.isHidden      = true
    }
    
    func layout() {
        addSubview(lockImageView)
        addSubview(passwordTextField)
        addSubview(toggleButton)
        addSubview(dividerView)
        addSubview(errorLabel)
        
        // lockImageView
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
            
        // passwordTextField
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: topAnchor),
            passwordTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1)
        ])
        // toggleButton
        NSLayoutConstraint.activate([
            toggleButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            toggleButton.leadingAnchor.constraint(equalToSystemSpacingAfter: passwordTextField.trailingAnchor, multiplier: 1),
            toggleButton.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        // divider
        NSLayoutConstraint.activate([
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: passwordTextField.bottomAnchor, multiplier: 1)
        ])
        
        // error label
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4)
        ])
        

    }
}


// MARK: - Actions
extension PasswordTextField {
    
    @objc func handleToggleButtonAction(_ sender: UIButton, forEvent event: UIEvent) {
        if let touch = event.allTouches?.first {
                let hiddenEyeImage   = UIImage(systemName: "eye.slash.fill")
                let visibleEyeImage  = UIImage(systemName: "eye.fill")
                passwordTextField.isSecureTextEntry.toggle()
                switch touch.phase {
                case .began:
                    toggleButton.setImage(hiddenEyeImage, for: .normal)
                case .ended:
                    toggleButton.setImage(visibleEyeImage, for: .normal)
                default:
                    break
                }
            }
        
        
    }
    
    @objc func toggleButtonTouchDown(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        toggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: [])
    }
}
