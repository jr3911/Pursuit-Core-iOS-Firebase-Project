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
    
    lazy var emailAddressTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textContentType = .emailAddress
        tf.borderStyle = .roundedRect
        tf.placeholder = "Email Address"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.textContentType = .newPassword
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
        button.backgroundColor = .clear
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
        guard emailAddressTextField.hasText, passwordTextField.hasText else {
            showAlert(title: "Unable to create account", message: "All fields must be filled", autoDismiss: false)
            return
        }
        
        if let email = emailAddressTextField.text, let password = passwordTextField.text {
            FirebaseAuthService.manager.createNewUser(email: email, password: password) { (result) in
                switch result {
                case .success:
                    if let currentUser = FirebaseAuthService.manager.currentUser {
                        let newUser = AppUser(from: currentUser)
                        FirestoreService.manager.createAppUser(user: newUser) { (result) in
                            switch result {
                            case .success:
                                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                    let sceneDelegate = windowScene.delegate as? SceneDelegate, let window = sceneDelegate.window
                                    else {
                                        self.dismiss(animated: true, completion: nil)
                                        return
                                }
                                UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromBottom, animations: {
                                    if FirebaseAuthService.manager.currentUser?.email != nil {
                                        window.rootViewController = PursuitstgramTabBarController()
                                    } else {
                                        window.rootViewController = ProfileVC()
                                    }
                                }, completion: { (_) in
                                    return window.rootViewController!.showAlert(title: "Welcome!", message: "Your account has been created successfully.", autoDismiss: true)
                                })
                            case .failure(let error):
                                self.showAlert(title: "Error", message: error.localizedDescription, autoDismiss: false)
                            }
                        }
                    }
                case .failure(let error):
                    self.showAlert(title: "Could not create account", message: error.localizedDescription, autoDismiss: false)
                }
            }
        }
    }
    
    @objc func closePage() {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - Private Functions
    private func addSubviews() {
        view.addSubview(pageTitleLabel)
        view.addSubview(textFieldStackView)
        
        textFieldStackView.addArrangedSubview(emailAddressTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        
        view.addSubview(submitButton)
        view.addSubview(closeButton)
    }
    
    
    //MARK: - Constraints
    private func constrainSubviews() {
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldStackView.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pageTitleLabel.heightAnchor.constraint(equalToConstant: 100),
            pageTitleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            textFieldStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            textFieldStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 100),
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


//MARK: - TextField Methods
extension CreateAccountVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
