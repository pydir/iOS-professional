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
    
    let titleLabel    = UILabel()
    let subtitleLabel  = UILabel()
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
    
    // animation
    var leadingEdgeOnScreen: CGFloat  = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad( )
        style()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
        errorLabel.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}

extension LoginViewController {
    private func style() {
        titleLabel.translatesAutoresizingMaskIntoConstraints      = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints    = false
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
        
        titleLabel.text           = "BankUp"
        titleLabel.numberOfLines  = 0
        titleLabel.font           = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textAlignment  = .center
        titleLabel.alpha          = 0
        
        subtitleLabel.text           = "Your premium source for all thinkings banking!"
        subtitleLabel.numberOfLines  = 0
        subtitleLabel.font           = UIFont.preferredFont(forTextStyle: .title2)
        subtitleLabel.textAlignment  = .center
        subtitleLabel.alpha          = 0
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorLabel)
        
        // Title
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        // Subtitle
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
            subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
            
        subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subtitleLeadingAnchor?.isActive = true
        
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
        view.endEditing(true)
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

extension LoginViewController {
    private func animate() {
        let duration:Double = 0.78
        
         let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.subtitleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.3)
        
        let animator3 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.3 )
    }
}
