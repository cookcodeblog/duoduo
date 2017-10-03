//
//  FeedCell.swift
//  duoduo
//
//  Created by William on 2017/10/2.
//  Copyright © 2017年 duoduo. All rights reserved.
//

import Foundation
import UIKit


class FeedCell: UICollectionViewCell {
    
    var post: Post? {
        didSet {
            
            setupNameLocationStatusAndProfileImage()
            
            statusImageView.image = nil
            
            if let statusImageUrl = post?.statusImageUrl {
                URLSession.shared.dataTask(with: URL(string: statusImageUrl)!, completionHandler: { (data, response, error) -> Void in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    let image = UIImage(data: data!)
                    
                    DispatchQueue.main.async(execute: {() -> Void in
                        self.statusImageView.image = image
                    })
                }).resume()
            }
        }
    }
    
    private func setupNameLocationStatusAndProfileImage() {
        if let name = post?.name,
            let location = post?.location, let issueDateTimeText = post?.issueDateTimeText {
            let attributedText = NSMutableAttributedString(string: name, attributes:
                [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
            
            attributedText.append(NSAttributedString(string: "\n\(location) \(issueDateTimeText)", attributes:
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
            
            
            nameLabel.attributedText = attributedText
        }
        
        if let statusText = post?.statusText {
            statusTextView.text = statusText
        }
        
        if let profileImageName = post?.profileImageName {
            profileImageView.image = UIImage(named: profileImageName)
        }
        
        
        if let numLikes = post?.numLikes , let numComments = post?.numComments {
            likesCommentsLabel.text = "\(numLikes) 点赞  \(numComments) 评论"
        }

    }
    
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
        
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        // Tips: Use background color to demo lay out
        //imageView.backgroundColor = UIColor.red
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
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
        
        
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, deviderViewLine, likeButton)
        
        // cosntraints with bottom
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
    }
    
    
}
