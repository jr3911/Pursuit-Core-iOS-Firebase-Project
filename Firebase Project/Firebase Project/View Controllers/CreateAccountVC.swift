//
//  CreateAccountVC.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/26/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    //MARK: - UI Objects
    lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 50)
        label.text = "Create Account"
        return label
    }()
    
    lazy var textFieldStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        return sv
    }()
    
    lazy var displayNameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Display Name"
        return tf
    }()
    
    lazy var emailAddressTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Email Address"
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.placeholder = "Password"
        return tf
    }()
    
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.close)
        button.addTarget(self, action: #selector(closePage), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        constrainSubviews()
    }
    
    
    //MARK: - Objective-C Methods
    @objc func createAccount() {
        if let email = emailAddressTextField.text, let displayName = displayNameTextField.text, let password = passwordTextField.text {
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closePage() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Private Functions
    private func addSubviews() {
        view.addSubview(pageTitleLabel)
        view.addSubview(textFieldStackView)
        
        textFieldStackView.addArrangedSubview(displayNameTextField)
        textFieldStackView.addArrangedSubview(emailAddressTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        
//        view.addSubview(displayNameTextField)
//        view.addSubview(emailAddressTextField)
//        view.addSubview(passwordTextField)
        
        view.addSubview(submitButton)
        view.addSubview(closeButton)
    }
    
    private func constrainSubviews() {
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
//        displayNameTextField.translatesAutoresizingMaskIntoConstraints = false
//        emailAddressTextField.translatesAutoresizingMaskIntoConstraints = false
//        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pageTitleLabel.heightAnchor.constraint(equalToConstant: 100),
            pageTitleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])

        
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 50),
            textFieldStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFieldStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25),
            textFieldStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 50),
            submitButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 30),
            submitButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    

}
