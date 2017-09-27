//
//  ViewController.swift
//  duoduo
//
//  Created by William on 2017/9/25.
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
        return CGSize(width: view.frame.width, height: 400) // TODO height
    }
    
    // rotate handling
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
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
             NSForegroundColorAttributeName: UIColor.rgb(red: 155, green: 161, blue: 171)]))
        
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
        imageView.image = UIImage(named: "code_profile")
        imageView.contentMode = .scaleAspectFit
        
        // Tips: Use background color to demo lay out
        //imageView.backgroundColor = UIColor.red
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "小朋友第一次参加编程比赛都非常兴奋！"
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "kid_program_pic02")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "488 点赞  107 评论"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
    }()
    
    
    let deviderViewLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    
    
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }
    
    let likeButton: UIButton = FeedCell.buttonForTitle(title: "点赞", imageName: "heart-shape-outline")
    let commentButton: UIButton = FeedCell.buttonForTitle(title: "评论", imageName: "comment-white-oval-bubble")
    let shareButton: UIButton = FeedCell.buttonForTitle(title: "分享", imageName: "share-symbol")

    
    func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(deviderViewLine)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        // Constraints of Auto lay out
        // TODO fine tune auto lay out constraints
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)

    
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        
        addConstraintsWithFormat(format: "H:|[v0]", views: statusImageView)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: deviderViewLine)
        
        // let "likeButton", "commentButton" and "shareButton" in one line; how/why ??
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        
        
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1(30)]-4-[v2]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, deviderViewLine, likeButton)
        
        // cosntraints with bottom
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
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

