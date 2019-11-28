//
//  ImageUploadVC.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/18/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class ImageUploadVC: UIViewController {
    //MARK: - UI Objects
    lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 50)
        label.text = "Upload an Image"
        return label
    }()
    
    lazy var imageButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setBackgroundImage(UIImage(systemName: "camera.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        button.addTarget(self, action: #selector(showImagePicker), for: .touchUpInside)
        return button
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Upload", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(uploadImage), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
    
    
    //MARK: - Objective-C Functions
    @objc func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func uploadImage() {
        guard let image = imageButton.backgroundImage(for: .normal) else {return}
        FirebaseStorageService.uploadManager.storeImage(image: image.jpegData(compressionQuality: 1)!) { (result) in
            switch result {
            case .success(let imageURL):
                let creatorID = FirebaseAuthService.manager.currentUser?.uid
                FirestoreService.manager.createPost(post: Post(title:
                    "Image", imageURL: imageURL.absoluteString, creatorID: creatorID!, dateCreated: Date())) { (result) in
                    switch result {
                    case .success:
                        self.showAlert(title: "Success!", message: "Your image was successfully uploaded", autoDismiss: true)
                        self.imageButton.setBackgroundImage(UIImage(systemName: "camera.fill"), for: .normal)
                        self.uploadButton.isEnabled = false
                    case .failure(let error):
                        self.showAlert(title: "Error", message: "Could not create a post\nError: \(error.localizedDescription)", autoDismiss: false)
                    }
                }
            case .failure(let error):
                self.showAlert(title: "Error", message: "Could not upload image\nError: \(error.localizedDescription)", autoDismiss: false)
            }
        }
    }
    
    
    
    //MARK: - Private Functions
    private func addSubviews() {
        view.addSubview(pageTitleLabel)
        view.addSubview(imageButton)
        view.addSubview(uploadButton)
        
        constrainSubviews()
    }
    
    private func constrainSubviews() {
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        uploadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pageTitleLabel.heightAnchor.constraint(equalToConstant: 150),
            pageTitleLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageButton.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 75),
            imageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageButton.heightAnchor.constraint(equalToConstant: 200),
            imageButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            uploadButton.topAnchor.constraint(equalTo: imageButton.bottomAnchor, constant: 75),
            uploadButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            uploadButton.heightAnchor.constraint(equalToConstant: 50),
            uploadButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}


//MARK: - ImagePicker Delegate
extension ImageUploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        self.imageButton.setBackgroundImage(image, for: .normal)
        self.uploadButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
}
