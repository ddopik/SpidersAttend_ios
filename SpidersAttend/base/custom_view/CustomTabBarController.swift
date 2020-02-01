//
//  CustomTabBarController.swift
//  SpidersAttend
//
//  Created by ddopik on 12/3/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//
import SwiftUI
import Floaty
class CustomTabBarController: UITabBarController {
    
 
     override func viewDidLoad() {
        super.viewDidLoad()
        // I've added this line to viewDidLoad
        UITabBarItem.appearance()
            .setTitleTextAttributes(
                [NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size:   16)!],
                for: .normal)

    }
     override func viewDidLayoutSubviews(){
        tabBar.frame = CGRect(x: 0, y:  0, width: tabBar.frame.size.width, height:tabBar.frame.size.height)
        tabBar.itemPositioning = UITabBar.ItemPositioning.centered
    }
    
   
    override func viewDidAppear(_ animated: Bool) {
             tabBar.frame = CGRect(x: 0, y:  0, width: tabBar.frame.size.width, height:tabBar.frame.size.height)
        tabBar.itemPositioning = UITabBar.ItemPositioning.centered
    }
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        view.layoutMargins = .zero
//        view.layoutMarginsDidChange()
//    }
}
