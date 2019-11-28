//
//  ImageHelper.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/27/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import Foundation

import UIKit

class ImageHelper {
    
    // MARK: - Static Properties
    
    static let shared = ImageHelper()
    
    
    //MARK: - Caching Properties
    
    let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Instance Methods
    
    func getImage(url: URL, completionHandler: @escaping (Result<UIImage, AppError>) -> ()) {
        
        //Checks cache to see if image was previously stored, before making network call
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completionHandler(.success(cachedImage))
        } else {
            
            //Makes network call to attempt to return image via url if available
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard error == nil else {
                    completionHandler(.failure(.badURL))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(.noDataReceived))
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    completionHandler(.failure(.notAnImage))
                    return
                }
                
                //Cache image for future use and return it
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completionHandler(.success(image))
                
            }.resume()
        }
    }
    
    // MARK: - Private Properties and Initializers
    
    private init() {}
}
