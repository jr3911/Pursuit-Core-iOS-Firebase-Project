//
//  FirebaseStorageService.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/27/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation
import FirebaseStorage

enum TypeOfImage: String {
    case profile = "profileImages"
    case upload = "uploadedImages"
}

class FirebaseStorageService {
    
    static let profileManager = FirebaseStorageService(typeOfImage: .profile)
    static let uploadManager = FirebaseStorageService(typeOfImage: .upload)
    
    private let storage: Storage!
    private let storageReference: StorageReference
    private let imagesFolderReference: StorageReference
    
    private init(typeOfImage: TypeOfImage) {
        storage = Storage.storage()
        storageReference = storage.reference()
        imagesFolderReference = storageReference.child(typeOfImage.rawValue)
    }
    
    func storeImage(image: Data,  completion: @escaping (Result<URL,Error>) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uuid = UUID()
        let imageLocation = imagesFolderReference.child(uuid.description)
        imageLocation.putData(image, metadata: metadata) { (responseMetadata, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                imageLocation.downloadURL { (url, error) in
                    guard error == nil else {completion(.failure(error!));return}
                    guard let url = url else {completion(.failure(error!));return}
                    completion(.success(url))
                }
            }
        }
    }
    
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> () ) {
        imagesFolderReference.storage.reference(forURL: url).getData(maxSize: Int64.max) { (data, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
