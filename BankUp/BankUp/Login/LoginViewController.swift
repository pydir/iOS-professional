//
//  ViewController.swift
//  BankUp
//
//  Created by Oguz Mert Beyoglu on 5.10.2024.
//

import UIKit

protocol LogoutDelegate {
    func didLogout()
}

protocol LoginViewControllerDelegate {
//    func didLogin(_ sender: LoginViewController) // pass data
    func didLogin()
    
}

class LoginViewController: UIViewController {
    let appNameLabel    = UILabel()
    let appSloganLabel  = UILabel()
    let loginView       = LoginView()
    var signInButton    = UIButton(type:.system)
    var errorLabel      = UILabel()
    
    var delegate: LoginViewControllerDelegate?
    
    var username: String? {
        loginView.usernameTextField.text
    }
    var password: String? {
        loginView.passwordTextField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad( )
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
}

extension LoginViewController {
    private func style() {
        appNameLabel.translatesAutoresizingMaskIntoConstraints      = false
        appSloganLabel.translatesAutoresizingMaskIntoConstraints    = false
        loginView.translatesAutoresizingMaskIntoConstraints         = false
        signInButton.translatesAutoresizingMaskIntoConstraints      = false
        errorLabel.translatesAutoresizingMaskIntoConstraints        = false
        
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorLabel.text             = "Incorrect username / password"
        errorLabel.textColor        = .systemRed
        errorLabel.textAlignment    = .center
        errorLabel.numberOfLines    = 0
        errorLabel.isHidden         = true
        
        appNameLabel.text           = "BankUp"
        appNameLabel.numberOfLines  = 0
        appNameLabel.font           = UIFont.preferredFont(forTextStyle: .title1)
        appNameLabel.textAlignment  = .center
        
        appSloganLabel.text           = "Your premium source for all thinkings banking!"
        appSloganLabel.numberOfLines  = 0
        appSloganLabel.font           = UIFont.preferredFont(forTextStyle: .title2)
        appSloganLabel.textAlignment  = .center
    }
    
    private func layout() {
        view.addSubview(appNameLabel)
        view.addSubview(appSloganLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorLabel)
        
        // Company Labels
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: appSloganLabel.bottomAnchor, multiplier: 4),
            appSloganLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appSloganLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),

            appSloganLabel.topAnchor.constraint(equalToSystemSpacingBelow: appNameLabel.bottomAnchor, multiplier: 2),
            appNameLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            appNameLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        // Login View
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2 ),
        ])
        
        // Button
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),
        ])
        
        // Error Label
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2),
            errorLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
    }
}

// MARK: - Actions
extension LoginViewController {
    @objc func signInTapped(_ sender: UIButton) {
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("username/password should never be nil")
            return
        }
        
//        if username.isEmpty || password.isEmpty {
//            configureView(withMessage: "Username / Password can't be blank!")
//            return
//        }
        
        if username == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
            self.delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username or password.")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorLabel.isHidden = false
        errorLabel.text     = message
    }
}
