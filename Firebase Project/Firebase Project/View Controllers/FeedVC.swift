//
//  FeedVC.swift
//  Firebase Project
//
//  Created by Jason Ruan on 11/18/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    //MARK: - UI Objects
    lazy var pageTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 50)
        label.text = "Feed"
        return label
    }()
    
    lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 180, height: 180)
        layout.minimumInteritemSpacing = 10
        layout.sectionInset.left = 10
        layout.sectionInset.right = 10
        layout.sectionInset.top = 10
        layout.sectionInset.bottom = 10
        
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: "postCell")
        return cv
    }()
    
    //MARK: - Properties
    var uploadedPosts: [Post] = [] {
        didSet {
            photosCollectionView.reloadData()
        }
    }
    
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        loadUploadedPosts()
        self.title = "FEED"
    }
    
    //MARK: - Private Functions
    private func loadUploadedPosts() {
        FirestoreService.manager.getAllPosts(sortingCriteria: nil) { (result) in
            switch result {
            case .success(let retrievedPosts):
                self.uploadedPosts = retrievedPosts
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addSubviews() {
        view.addSubview(photosCollectionView)
        constrainSubviews()
    }
    
    private func constrainSubviews() {
        photosCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photosCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photosCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            photosCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


//MARK: CollectionView Methods
extension FeedVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return uploadedPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! FeedCollectionViewCell
        let currentPost = uploadedPosts[indexPath.row]
        
        cell.imageView.image = UIImage(systemName: "photo.fill")
        
        guard let imageURL = URL(string: currentPost.imageURL) else { return cell }
        ImageHelper.shared.getImage(url: imageURL) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
        return cell
    }
    
    
}
