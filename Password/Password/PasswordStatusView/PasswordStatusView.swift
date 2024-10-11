//
//  PasswordStatusView.swift
//  Password
//
//  Created by Oguz Mert Beyoglu on 11.10.2024.
//

import Foundation
import UIKit

class PasswordStatusView: UIView {
    let stackView       = UIStackView()
    let criteriaLabel   = UILabel()
    
    let lengthCriteriaView          = PasswordCriteriaView(text: "8-32 characters(no spaces)")
    let upperCaseCriteriaView       = PasswordCriteriaView(text: "uppercase letter(A-Z")
    let lowercaseCriteriaView       = PasswordCriteriaView(text: "lowercase(a-z")
    let digitCriteriaView           = PasswordCriteriaView(text: "digit (0-9)")
    let specialCharacterCriteriaView = PasswordCriteriaView(text: "special characters (e.g. !@#$%^")
    
    var shouldResetCriteria: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    
}

extension PasswordStatusView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        layer.cornerRadius = 7
        clipsToBounds = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis              = .vertical
        stackView.spacing           = 8
        stackView.distribution      = .equalCentering
        
        lengthCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        upperCaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        lowercaseCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        digitCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        specialCharacterCriteriaView.translatesAutoresizingMaskIntoConstraints = false
        
        criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        //        criteriaLabel.text = "User at least 3 of these 3 criteria when settings your password:"
        criteriaLabel.numberOfLines  = 0
        criteriaLabel.lineBreakMode  = .byWordWrapping
        criteriaLabel.attributedText = makeCriteriaMessage()
    }
    
    func layout() {
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(upperCaseCriteriaView)
        stackView.addArrangedSubview(lowercaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
        
        addSubview(stackView)
        
        
        // Base View
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
        ])
        
    }
    
    private func makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes               = [NSAttributedString.Key: AnyObject]()
        plainTextAttributes[.font]            = UIFont.preferredFont(forTextStyle: .subheadline)
        plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
        
        var boldTextAttributes                = [NSAttributedString.Key: AnyObject]()
        boldTextAttributes[.foregroundColor]  = UIColor.label
        boldTextAttributes[.font]             = UIFont.preferredFont(forTextStyle: .subheadline)
        
        let attrText    = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
        attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
        attrText.append(NSAttributedString(string: "criteria when settings your password:", attributes: plainTextAttributes))
        
        return attrText
    }
}


extension PasswordStatusView {
    func updateDisplay(_ text: String) {
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        let uppercaseMet        = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet        = PasswordCriteria.lowercaseMet(text)
        let digitMet            = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        if shouldResetCriteria {
            lengthAndNoSpaceMet
            ? lengthCriteriaView.isCriteriaMet  = true
            : lengthCriteriaView.reset()
            
            uppercaseMet
            ? upperCaseCriteriaView.isCriteriaMet   = true
            : upperCaseCriteriaView.reset()
            
            lowercaseMet
            ? lowercaseCriteriaView.isCriteriaMet   = true
            : lowercaseCriteriaView.reset()
            
            digitMet
            ? digitCriteriaView.isCriteriaMet       = true
            : digitCriteriaView.reset()
            
            specialCharacterMet
            ? specialCharacterCriteriaView.isCriteriaMet = true
            : specialCharacterCriteriaView.reset()
        } else {
            lengthCriteriaView.isCriteriaMet            = lengthAndNoSpaceMet
            upperCaseCriteriaView.isCriteriaMet         = uppercaseMet
            lowercaseCriteriaView.isCriteriaMet         = lowercaseMet
            digitCriteriaView.isCriteriaMet             = digitMet
            specialCharacterCriteriaView.isCriteriaMet   = specialCharacterMet
        }
    }
    
    func validate(_ text: String) -> Bool {
        let uppercaseMet = PasswordCriteria.uppercaseMet(text)
        let lowercaseMet = PasswordCriteria.lowercaseMet(text)
        let digitMet     = PasswordCriteria.digitMet(text)
        let specialCharacterMet = PasswordCriteria.specialCharacterMet(text)
        
        let checkable   = [uppercaseMet, lowercaseMet, digitMet, specialCharacterMet]
        let metCriteria = checkable.filter { $0 }
        let lengthAndNoSpaceMet = PasswordCriteria.lengthAndNoSpaceMet(text)
        
        if lengthAndNoSpaceMet && metCriteria.count >= 3 {
            return true
        }
        
        return false
    }
    
    func reset() {
        lengthCriteriaView.reset()
        upperCaseCriteriaView.reset()
        lowercaseCriteriaView.reset()
        digitCriteriaView.reset()
        specialCharacterCriteriaView.reset()
    }
}
