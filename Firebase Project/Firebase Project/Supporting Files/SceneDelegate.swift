//
//  SceneDelegate.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/18/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        
        checkIfUserStillValid { (result) in
            switch result {
            case .success:
                self.window?.rootViewController = PursuitstgramTabBarController()
            case .failure:
                self.window?.rootViewController = LoginVC()
            }
        }
        
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate {
    func checkIfUserStillValid(completionHandler: @escaping (Result<Bool, AppError>) -> () ) {
        guard let currentUser = FirebaseAuthService.manager.currentUser else {
            completionHandler(.failure(.noCurrentUser))
            return
        }
        currentUser.getIDTokenForcingRefresh(true) { (idToken, error) in
            if let error = error {
                print(error.localizedDescription)
                //TODO: Fix when to remove user from database
                //Below comment block will not work because read,write permissions are dependent on request.auth, which the user does not have if deleted from authentification
                
//                FirestoreService.manager.deleteUserData(userID: currentUser.uid.description) { (result) in
//                    switch result {
//                    case .success:
//                        print("User was successfully removed from database")
//                    case .failure(let error):
//                        print("User was not removed from database\nError: \(error)")
//                    }
//                }
                
                FirebaseAuthService.manager.logoutUser()
                completionHandler(.failure(.other(rawError: error)))
            } else {
                completionHandler(.success(true))
            }
        }
    }
}

