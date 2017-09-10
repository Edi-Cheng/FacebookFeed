//
//  FeedController.swift
//  FacebookFeed
//
//  Created by Lin Cheng on 10/09/2017.
//  Copyright © 2017 Lin Cheng. All rights reserved.
//
import Foundation
import UIKit

let cellId = "cellId"

let posts = Posts()

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        URLCache.shared = urlCache
        
        navigationItem.title = "Facebook Feed"
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)

        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.numberOfPosts()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath]
        
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath].statusText {
            
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000)
, options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize:14)], context: nil)
            
            let knowHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return CGSize(width: view.frame.width, height: rect.height + knowHeight + 24)
            
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
    }

}







