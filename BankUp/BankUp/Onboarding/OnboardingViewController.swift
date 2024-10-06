//
//  OnboardingViewController.swift
//  BankUp
//
//  Created by Oguz Mert Beyoglu on 6.10.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    let stackView   = UIStackView()
    let imageView   = UIImageView()
    let label       = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension OnboardingViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis      = .vertical
        stackView.spacing   = 20
        
        // Image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode   = .scaleAspectFit
        imageView.image         = UIImage(named: "delorean")
        
        // Label
        label.translatesAutoresizingMaskIntoConstraints     = false
        label.textAlignment = .center
        label.text          = "Banking at Your Fingertips, Anytime, Anywhere."
        label.font          = UIFont.preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
    }
    
    func layout() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
        ])
    }
}
