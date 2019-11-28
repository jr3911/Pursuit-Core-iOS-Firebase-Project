//
//  ImageDetailVC.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/18/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class ImageDetailVC: UIViewController {
    //MARK: - UI Objects
    lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 50)
        label.text = "Image Details"
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var submitterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var dateCreatedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    
    //MARK: - Properties
    var selectedImage: UIImage? {
        didSet {
            self.imageView.image = self.selectedImage
        }
    }
    
    var selectedPost: Post? {
        didSet {
//            self.submitterLabel.text = "Submitted by: \(self.selectedPost?.creatorID.description ?? "N/A")"
            self.dateCreatedLabel.text = "Created on: \(self.selectedPost?.dateCreated?.description ?? "N/A")"
            
            FirestoreService.manager.getUser(userID: self.selectedPost?.creatorID.description ?? "N/A") { (result) in
                switch result {
                case .success(let submitter):
                    self.submitterLabel.text = "Submitted by: \(submitter.displayName ?? "N/A")"
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
    }
    
    //MARK: - Private Functions
    private func addSubviews() {
        view.addSubview(pageTitleLabel)
        view.addSubview(imageView)
        view.addSubview(submitterLabel)
        view.addSubview(dateCreatedLabel)
        
        constrainSubviews()
    }
    
    private func constrainSubviews() {
        pageTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        submitterLabel.translatesAutoresizingMaskIntoConstraints = false
        dateCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pageTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            pageTitleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pageTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
            pageTitleLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width - 10),
            imageView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height / 3)
        ])
        
        NSLayoutConstraint.activate([
            submitterLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            submitterLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            submitterLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 10),
            submitterLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            dateCreatedLabel.topAnchor.constraint(equalTo: submitterLabel.bottomAnchor, constant: 20),
            dateCreatedLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dateCreatedLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 10),
            dateCreatedLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
}
