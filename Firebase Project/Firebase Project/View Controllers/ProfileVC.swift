//
//  ProfileVC.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/18/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: - UI Objects
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Profile"
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "photo.fill"))
        if let photoURL = FirebaseAuthService.manager.currentUser?.photoURL {
            ImageHelper.shared.getImage(url: photoURL) { (result) in
                switch result {
                case .success(let profileImage):
                    DispatchQueue.main.async {
                        self.profileImage.image = profileImage
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var changeProfileImageButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setBackgroundImage(UIImage(systemName:"plus.circle.fill"), for: .normal)
        button.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(editProfile(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var userDisplayNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = FirebaseAuthService.manager.currentUser?.displayName ?? "DisplayName"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    lazy var editDisplayNameButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action: #selector(editProfile(sender:)), for: .touchUpInside)
        return button
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = FirebaseAuthService.manager.currentUser?.email ?? "Email Address"
        return label
    }()
    
    lazy var numUserSubmissionsLabel: UILabel = {
        let label = UILabel()
        //TODO: Replace text with number of user submissions
        label.text = "You have submitted __ images"
        return label
    }()
    
    //MARK: - Properties
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubview()
    }
    
    
    //MARK: Objective-C Functions
    @objc func editProfile(sender: UIButton) {
        switch sender {
        case changeProfileImageButton:
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        case editDisplayNameButton:
            showAlertWithTextField(title: "Edit Display Name", message: "This is the name that other members will see", label: userDisplayNameLabel)
        default:
            break
        }
    }
    
    //MARK: - Private Functions
    private func addSubview() {
        view.addSubview(profileLabel)
        view.addSubview(profileImage)
        view.addSubview(changeProfileImageButton)
        view.addSubview(userDisplayNameLabel)
        view.addSubview(editDisplayNameButton)
        view.addSubview(emailLabel)
        view.addSubview(numUserSubmissionsLabel)
        
        constrainSubviews()
    }
    
    
    //MARK: - Constraints
    private func constrainSubviews() {
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        changeProfileImageButton.translatesAutoresizingMaskIntoConstraints = false
        userDisplayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        editDisplayNameButton.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        numUserSubmissionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            profileLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileLabel.heightAnchor.constraint(equalToConstant: 50),
            profileLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 100),
            profileImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
        ])
        
        NSLayoutConstraint.activate([
            changeProfileImageButton.centerYAnchor.constraint(equalTo: profileImage.topAnchor, constant: 10),
            changeProfileImageButton.centerXAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: -20),
            changeProfileImageButton.heightAnchor.constraint(equalToConstant: 50),
            changeProfileImageButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            userDisplayNameLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            userDisplayNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            userDisplayNameLabel.heightAnchor.constraint(equalToConstant: 50),
            userDisplayNameLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            editDisplayNameButton.topAnchor.constraint(equalTo: userDisplayNameLabel.bottomAnchor, constant: 10),
            editDisplayNameButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            editDisplayNameButton.heightAnchor.constraint(equalToConstant: 20),
            editDisplayNameButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: editDisplayNameButton.bottomAnchor, constant: 100),
            emailLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 30),
            emailLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            numUserSubmissionsLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            numUserSubmissionsLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            numUserSubmissionsLabel.heightAnchor.constraint(equalToConstant: 30),
            numUserSubmissionsLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -50)
        ])
        
    }
}


//MARK: ImagePicker Delegate
extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        FirebaseStorageService.profileManager.storeImage(image: image.jpegData(compressionQuality: 1)!) { (result) in
            switch result {
            case .success(let imageURL):
                FirebaseAuthService.manager.updateProfile(displayName: nil, photoURL: imageURL) { (result) in
                    switch result {
                    case .success:
                        self.profileImage.image = image
                        self.showAlert(title: "All set!", message: "Your profile image updated successfully", autoDismiss: true)
                        FirestoreService.manager.updateCurrentUser(userName: nil, photoURL: imageURL) { (result) in
                            switch result {
                            case .success:
                                return
                            case .failure(let error):
                                self.showAlert(title: "Error", message: "There was a problem when trying to update user photo to Firestore database\nError: \(error.localizedDescription)", autoDismiss: false)
                            }
                        }
                        
                    case .failure(let error):
                        self.showAlert(title: "Error", message: "Could not update profile image\nError:\(error)", autoDismiss: false)
                    }
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: "Could not upload photo\nError: \(error.localizedDescription)", autoDismiss: false)
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}
