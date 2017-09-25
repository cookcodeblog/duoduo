//
//  ViewController.swift
//  duoduo
//
//  Created by linsirui on 2017/9/25.
//  Copyright © 2017年 duoduo. All rights reserved.
//

import UIKit

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // Application Properties
    let NAVIGATION_ITEM_TITLE = "朵朵";
    let CELL_ID = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NAVIGATION_ITEM_TITLE
        
        // 支持上下滑动
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: CELL_ID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ID, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60) // TODO height
    }


}

class FeedCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        let attributedText = NSMutableAttributedString(string: "少儿编程大赛10月9日在广州举行", attributes:
            [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\n编程兔 126评论 16分钟前", attributes:
            [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 10),
             NSForegroundColorAttributeName: UIColor(red: 155/255, green: 161/255, blue: 171/255, alpha: 1) ]))
        
        // line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        
        
        attributedText.addAttributes([NSParagraphStyleAttributeName: paragraphStyle],
                                     range: NSMakeRange(0, attributedText.string.characters.count))
        
        // what is it ? keep it atm, attachments ?
//        let attachment = NSTextAttachment()
//        attachment.image = UIImage(named: "global_small")
//        attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
//        attributedText.append(NSAttributedString(attachment: attachment))
        
        
        label.attributedText = attributedText
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "kid_program")
        imageView.contentMode = .scaleAspectFit
        
        // Tips: Use background color to demo lay out
        //imageView.backgroundColor = UIColor.red
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        
        // Constraints of Auto lay out
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]|", views: profileImageView)
        
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewDictionary))
    }
    
    
}

