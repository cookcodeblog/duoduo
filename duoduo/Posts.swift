//
//  Posts.swift
//  duoduo
//
//  Created by William on 2017/10/2.
//  Copyright © 2017年 duoduo. All rights reserved.
//

import Foundation

class Post {
    var name: String?
    var statusText: String?
    var profileImageName: String?
    var statusImageName: String?
    var numLikes: Int?
    var numComments: Int?
    var location: String?
    var issueDateTimeText: String?
    var statusImageUrl: String?
}

class Posts {
    private let postsList: [Post]
    
    init() {
        let postKidCoding = Post()
        postKidCoding.name = "编程兔"
        postKidCoding.location = "广州天河"
        postKidCoding.issueDateTimeText = "16分钟前"
        postKidCoding.statusText = "小朋友们第一次参加编程比赛都很兴奋。"
        postKidCoding.profileImageName = "code_profile"
        postKidCoding.statusImageName = "kid_program_pic04"
        postKidCoding.numLikes = 146
        postKidCoding.numComments = 24
        postKidCoding.statusImageUrl = "http://wx1.sinaimg.cn/mw690/006RF1rrgy1fk4b33ouavj30af06y755.jpg"
        
        let postKidDancing = Post()
        postKidDancing.name = "唐韵少儿中国舞"
        postKidDancing.location = "广州番禺"
        postKidDancing.issueDateTimeText = "18分钟前"
        postKidDancing.statusText = "热烈祝贺第26次中国舞考级考试圆满落幕。\n中国舞班的全体学员全部顺利通过考级。\n再次对全体学员表示祝贺！"
        postKidDancing.profileImageName = "dance_profile"
        postKidDancing.statusImageName = "kid_dancing_pic01"
        postKidDancing.numLikes = 258
        postKidDancing.numComments = 56
        postKidDancing.statusImageUrl = "http://wx3.sinaimg.cn/mw690/006RF1rrgy1fk4b2emlpuj30af07tdgh.jpg"
        
        let postKidLunhua = Post()
        postKidLunhua.name = "风火轮少儿轮滑"
        postKidLunhua.location = "番禺亚运城"
        postKidLunhua.issueDateTimeText = "23分钟前"
        postKidLunhua.statusText = "速滑比赛选手风采"
        postKidLunhua.profileImageName = "lunhua_profile"
        postKidLunhua.numLikes = 156
        postKidLunhua.numComments = 25
        postKidLunhua.statusImageUrl = "http://wx1.sinaimg.cn/mw690/006RF1rrgy1fk4bo3dmfzj30af06taad.jpg"
        
        
        postsList = [postKidCoding, postKidDancing, postKidLunhua]
    }
    
    func numberOfPosts() -> Int {
        return postsList.count
    }
    
    subscript(indexPath: IndexPath) -> Post {
        get {
            return postsList[indexPath.item]
        }
    }
}

