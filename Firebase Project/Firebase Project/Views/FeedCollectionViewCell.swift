//
//  FeedCollectionViewCell.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/18/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    //MARK: - UI Objects
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    //MARK: - Properties
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Functions
    private func addSubviews() {
        contentView.addSubview(imageView)
        constrainSubviews()
    }
    
    private func constrainSubviews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
