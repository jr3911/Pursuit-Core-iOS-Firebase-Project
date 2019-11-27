//
//  PublicViewControllerFunctions.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/26/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    //MARK: - Shared Functions
    public func showAlert(title: String, message: String, autoDismiss: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if autoDismiss {
            present(alert, animated: true) {
                sleep(1)
                alert.dismiss(animated: true, completion: nil)
            }
        } else {
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    public func showAlertWithTextField(title: String, message: String, label: UILabel?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter a display name"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] (_) in
            guard let textfield = alert?.textFields?[0] else { return }
            guard textfield.hasText else {
                self.showAlert(title: "Not a valid display name", message: "Please enter a display name", autoDismiss: true)
                return
            }
            if let newDisplayName = textfield.text {
                FirebaseAuthService.manager.updateProfile(displayName: newDisplayName, photoURL: nil) { (result) in
                    switch result{
                    case .failure(let error):
                        print(error)
                        self.showAlert(title: "Error", message: "Could not change display name", autoDismiss: false)
                    case .success:
                        FirestoreService.manager.updateCurrentUser(userName: newDisplayName, photoURL: nil) { (result) in
                            switch result {
                            case .success:
                                self.showAlert(title: "All set!", message: "Your display name was updated successfully", autoDismiss: true)
                                if let label = label {
                                    label.text = newDisplayName
                                }
                            case .failure(let error):
                                self.showAlert(title: "Error", message: "Could not update display name to Firestore database\nError: \(error.localizedDescription)", autoDismiss: false)
                            }
                        }
                    }
                }
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
