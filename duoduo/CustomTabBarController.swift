//
//  CustomTabBarController.swift
//  duoduo
//
//  Created by William on 2017/10/3.
//  Copyright © 2017年 duoduo. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Home screen
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        navigationController.title = "首页"
        navigationController.tabBarItem.image = UIImage(named: "home_icon")
        
        // Calendar screen
        let calendarController = CalendarController()
        let secondNavigationController = UINavigationController(rootViewController: calendarController)
        secondNavigationController.title = "日程"
        secondNavigationController.tabBarItem.image = UIImage(named: "calendar_icon")
        
        
        
        // Course screen
        let courseController = CourseController()
        let thirdNavigationController = UINavigationController(rootViewController: courseController)
        thirdNavigationController.title = "课程"
        thirdNavigationController.tabBarItem.image = UIImage(named: "course_icon")

        
        
        // User screen
        let userController = UserController()
        let fourthNavigationController = UINavigationController(rootViewController: userController)
        fourthNavigationController.title = "我的"
        fourthNavigationController.tabBarItem.image = UIImage(named: "user_icon")
        
        
        viewControllers = [navigationController, secondNavigationController, thirdNavigationController, fourthNavigationController]
        
        
        tabBar.isTranslucent = false
        
        // Change tab bar top devider line from 1px to 0.5 px
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true

    }
}
