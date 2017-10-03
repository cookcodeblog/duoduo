//
//  ViewController.swift
//  duoduo
//
//  Created by William on 2017/9/25.
//  Copyright © 2017年 duoduo. All rights reserved.
//

import UIKit

// Application Properties
let NAVIGATION_ITEM_TITLE = "朵朵";
let CELL_ID = "feed_cellId"

let posts = Posts()


class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NAVIGATION_ITEM_TITLE
        
        // Use a cache on View Controller level
        
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = memoryCapacity
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "duoduo_store")
        URLCache.shared = urlCache
        
        // 支持上下滑动
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: CELL_ID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // section count
        return posts.numberOfPosts()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath) as! FeedCell
        feedCell.post = posts[indexPath]
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // calculate text height dynamically
        if let statusText = posts[indexPath].statusText {
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            // align with auto lay out vectical constraints
            let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            let textSpacing: CGFloat = 24
            
            return CGSize(width: view.frame.width, height: rect.height + knownHeight + textSpacing)
        }
        return CGSize(width: view.frame.width, height: 500) // TODO height
    }
    
    // rotate handling
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }


}



