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
}
