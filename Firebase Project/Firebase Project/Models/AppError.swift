//
//  AppError.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/26/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

enum AppError: Error {
    case noCurrentUser
    case other(rawError: Error)
}
