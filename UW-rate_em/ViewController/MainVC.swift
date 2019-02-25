//
//  MainVC.swift
//  UW-rate_em
//
//  Created by Anthony Leung on 2/18/19.
//  Copyright © 2019 Anthony Leung. All rights reserved.
//

import UIKit

class MainVC : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.95, green:0.45, blue:0.45, alpha:1.0)
        self.delegate = self
        self.tabBar.unselectedItemTintColor = UIColor.black
        self.tabBar.tintColor = UIColor.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let courseAndAssignmentVC = Course_AssignmentVC()
        let courseImage = UIImage(named: "course")
        let courseBarItem = UITabBarItem(title: "Couse", image: courseImage, selectedImage: courseImage)
        courseBarItem.setTitleTextAttributes([.font : UIFont(name: "Futura", size: 10)!], for: .normal)
        courseAndAssignmentVC.tabBarItem = courseBarItem
        
        let myCourseVC = MyCourseVC()
        let myCourseImage = UIImage(named: "mycourse")
        let myCourseBarItem = UITabBarItem(title: " My Couse", image: myCourseImage, selectedImage: myCourseImage)
        myCourseBarItem.setTitleTextAttributes([.font : UIFont(name: "Futura", size: 10)!], for: .normal)
        myCourseVC.tabBarItem = myCourseBarItem
        
        let myAssignmentVC = MyAssignmentVC()
        let myAssignmentImage = UIImage(named: "myassignment")
        let myAssignmentBarItem = UITabBarItem(title: " My Assignment", image: myAssignmentImage, selectedImage: myAssignmentImage)
        myAssignmentBarItem.setTitleTextAttributes([.font : UIFont(name: "Futura", size: 10)!], for: .normal)
        myAssignmentVC.tabBarItem = myAssignmentBarItem
        
        let profileVC = ProfileVC()
        let profileImage = UIImage(named: "me")
        let profileBarItem = UITabBarItem(title: "Me", image: profileImage, selectedImage: profileImage)
        profileBarItem.setTitleTextAttributes([.font : UIFont(name: "Futura", size: 10)!], for: .normal)
        profileVC.tabBarItem = profileBarItem
        
        
        self.viewControllers = [courseAndAssignmentVC,myCourseVC,myAssignmentVC,profileVC]
        
    }
}

extension MainVC : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
}
