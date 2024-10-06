//
//  HomeViewController.swift
//  BankUp
//
//  Created by Oguz Mert Beyoglu on 6.10.2024.
//


import UIKit

class HomeViewController: UIViewController {
    var delegate: LogoutDelegate?
    
    let stackView    = UIStackView()
    let label        = UILabel()
    let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

extension HomeViewController {
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis      = .vertical
        stackView.spacing   = 20
        
        label.translatesAutoresizingMaskIntoConstraints     = false
        label.text          = "Hello"
        label.font          = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.configuration = .filled()
        logoutButton.configuration?.imagePadding = 8
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
        
    }
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButton)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

extension HomeViewController {
    @objc private func logoutTapped(_ sender: UIButton) {
        self.delegate?.didLogout()
    }
}
