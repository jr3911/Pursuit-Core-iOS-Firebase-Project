//
//  ProfileVC.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/18/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    //MARK: UI Objects
    lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(systemName: "photo.fill"))
        return iv
    }()
    
    lazy var userDisplayNameLabel: UILabel = {
        let label = UILabel()
        //TODO: Replace text with user's displayname
        label.text = "DisplayName"
        return label
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Edit", for: .normal)
        return button
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        //TODO: Replace text with user's email
        label.text = "Email Address"
        return label
    }()
    
    lazy var numUserSubmissionsLabel: UILabel = {
        let label = UILabel()
        //TODO: Replace text with number of user submissions
        label.text = "You have submitted __ images"
        return label
    }()
    
    //MARK: Properties
    
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: Private Functions
    private func addSubview() {
        view.addSubview(profileLabel)
        view.addSubview(profileImage)
        view.addSubview(userDisplayNameLabel)
        view.addSubview(editButton)
        view.addSubview(emailLabel)
        view.addSubview(numUserSubmissionsLabel)
    }
    
}
