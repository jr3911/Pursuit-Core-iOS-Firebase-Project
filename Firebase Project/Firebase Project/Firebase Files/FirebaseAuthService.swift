//
//  FirebaseAuthentificationService.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/18/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseAuthService {
    
    static let manager = FirebaseAuthService()
    private init() {}
    private let auth = Auth.auth()

    var currentUser: User? {
        return auth.currentUser
    }
    
    func createNewUser(email: String, password: String, completion: @escaping (Result<User,Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { (result, error) in
            if let createdUser = result?.user {
                completion(.success(createdUser))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func updateProfile(displayName: String?, photoURL: URL?, completion: @escaping (Result<(),Error>) -> ()){
        let profileChangeRequest = auth.currentUser?.createProfileChangeRequest()
        if let displayName = displayName {
            profileChangeRequest?.displayName = displayName
        }
        if let photoURL = photoURL {
            profileChangeRequest?.photoURL = photoURL
        }
        profileChangeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        })
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<(), AppError>) -> ()) {
        auth.signIn(withEmail: email, password: password) { (result, error) in
            if let _ = result?.user {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(.other(rawError: error)))
            }
        }
    }
    
    func logoutUser() {
        do {
            try auth.signOut()
        } catch {
            return
        }
    }

}
