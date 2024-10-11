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
    
    let criteriaView1   = PasswordCriteriaView(text: "8-32 characters(no spaces)")
    let criteriaView2   = PasswordCriteriaView(text: "uppercase letter(A-Z")
    let criteriaView3   = PasswordCriteriaView(text: "lowercase(a-z")
    let criteriaView4   = PasswordCriteriaView(text: "digit (0-9)")
    let criteriaView5   = PasswordCriteriaView(text: "special characters (e.g. !@#$%^")
    
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
        
        criteriaView1.translatesAutoresizingMaskIntoConstraints = false
        criteriaView2.translatesAutoresizingMaskIntoConstraints = false
        criteriaView3.translatesAutoresizingMaskIntoConstraints = false
        criteriaView4.translatesAutoresizingMaskIntoConstraints = false
        criteriaView5.translatesAutoresizingMaskIntoConstraints = false
        
        criteriaLabel.translatesAutoresizingMaskIntoConstraints = false
//        criteriaLabel.text = "User at least 3 of these 3 criteria when settings your password:"
        criteriaLabel.numberOfLines  = 0
        criteriaLabel.lineBreakMode  = .byWordWrapping
        criteriaLabel.attributedText = makeCriteriaMessage()
    }
    
    func layout() {
        stackView.addArrangedSubview(criteriaView1)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(criteriaView2)
        stackView.addArrangedSubview(criteriaView3)
        stackView.addArrangedSubview(criteriaView4)
        stackView.addArrangedSubview(criteriaView5)
        
        addSubview(stackView)
        
        
        // Base View
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 2),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 2)
        ])
        
        // Label
        
        NSLayoutConstraint.activate([
            criteriaLabel.topAnchor.constraint(equalToSystemSpacingBelow: criteriaView1.bottomAnchor, multiplier: 2),
            criteriaLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: 2),
            trailingAnchor.constraint(equalToSystemSpacingAfter: criteriaLabel.trailingAnchor, multiplier: 2),
            
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
