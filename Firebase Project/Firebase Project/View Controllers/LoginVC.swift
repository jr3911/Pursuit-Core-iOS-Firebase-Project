//
//  LoginVC.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/18/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //MARK: - UI Objects
    lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pursuitstgram"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.borderStyle = .bezel
        tf.autocorrectionType = .no
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .bezel
        tf.autocorrectionType = .no
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var createAccountButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(showCreateAccountPage), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
    }
    
    
    //MARK: - Objective-C Functions
    @objc func showCreateAccountPage() {
        present(CreateAccountVC(), animated: true, completion: nil)
    }
    
    //MARK: - Private Functions
    private func setUpViews() {
        view.addSubview(appTitleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        
        constrainAppTitleLabel()
        constrainEmailTextField()
        constrainPasswordTextField()
        constrainLoginButton()
        constrainCreateAccountButton()
    }
    
    
    //MARK: - Constraints
    private func constrainAppTitleLabel() {
        appTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            appTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            appTitleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            appTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            appTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func constrainEmailTextField() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 250),
            emailTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 100),
            emailTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func constrainPasswordTextField() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 100),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func constrainLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 150),
            loginButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            loginButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func constrainCreateAccountButton() {
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            createAccountButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            createAccountButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            createAccountButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
