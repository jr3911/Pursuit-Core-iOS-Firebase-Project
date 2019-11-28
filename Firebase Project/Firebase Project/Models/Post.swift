//
//  Post.swift
//  firebae-reddit-clone
//
//  Created by David Rifkin on 11/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct Post {
    let title: String?
    let imageURL: String
    let id: String
    let creatorID: String
    let dateCreated: Date?
    
    init(title: String? = nil, imageURL: String, creatorID: String, dateCreated: Date? = nil) {
        self.title = title
        self.imageURL = imageURL
        self.creatorID = creatorID
        self.id = UUID().description
        self.dateCreated = dateCreated
    }
    
    init?(from dict: [String: Any], id: String) {
        guard let imageURL = dict["imageURL"] as? String,
              let userID = dict["creatorID"] as? String,
              let dateCreated = (dict["dateCreated"] as? Timestamp)?.dateValue() else { return nil }
        
        let title = dict["title"] as? String ?? "Image"
        self.title = title
        self.imageURL = imageURL
        self.creatorID = userID
        self.id = id
        self.dateCreated = dateCreated
    }
    
    var fieldsDict: [String: Any] {
        return [
            "title": self.title,
            "imageURL": self.imageURL,
            "creatorID": self.creatorID,
            "dateCreated": self.dateCreated
        ]
    }
}
