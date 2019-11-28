//
//  PursuitstagramTabBarController.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/27/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class PursuitstgramTabBarController: UITabBarController {
    //MARK: View Controllers
    lazy var feedVC = UINavigationController(rootViewController: FeedVC())
    lazy var uploadVC = UINavigationController(rootViewController: ImageUploadVC())
    lazy var profileVC: UINavigationController = UINavigationController(rootViewController: ProfileVC())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "photo.fill.on.rectangle.fill"), tag: 0)
        uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "camera.fill"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle.fill"), tag: 2)
        if let rootFeedVC = feedVC.viewControllers[0] as? FeedVC, let rootProfileVC = profileVC.viewControllers[0] as? ProfileVC {
            rootFeedVC.delegate = rootProfileVC
        }
        self.viewControllers = [feedVC, uploadVC, profileVC]
    }
}
