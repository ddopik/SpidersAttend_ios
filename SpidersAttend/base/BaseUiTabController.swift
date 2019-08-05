//
//  BaseUiTabController.swift
//  SpidersAttend
//
//  Created by ddopik on 7/21/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit

class BaseUiTabController: UITabBarController,UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
         self.tabBarController?.delegate = self
        self.delegate = self;
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // this line need
                       self.tabBarController?.tabBar.items?[0].title = "Home".localiz()
                    self.tabBarController?.tabBar.items?[1].title = "Attend".localiz()
                     self.tabBarController?.tabBar.items?[2].title = "Vication (CommingSoon)".localiz()
                      self.tabBarController?.tabBar.items?[3].title = "PayRoll (CommingSoon)".localiz()
                     self.tabBarController?.tabBar.items?[4].title = "more".localiz()
    }
    //    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    //        let tabBarIndex = tabBarController.selectedIndex
    ////        if tabBarIndex == 0 {
    //            self.tabBarController?.tabBar.items?[0].title = "Home".localiz()
    //            self.tabBarController?.tabBar.items?[1].title = "Attend".localiz()
    //             self.tabBarController?.tabBar.items?[2].title = "Vication (CommingSoon)".localiz()
    //              self.tabBarController?.tabBar.items?[3].title = "PayRoll (CommingSoon)".localiz()
    //             self.tabBarController?.tabBar.items?[4].title = "more".localiz()
    ////         }
    //    }
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected item")
//        self.tabBarController?.tabBar.items?[0].title = "Home".localiz()
//        self.tabBarController?.tabBar.items?[1].title = "Attend".localiz()
//        self.tabBarController?.tabBar.items?[2].title = "Vication (CommingSoon)".localiz()
//        self.tabBarController?.tabBar.items?[3].title = "PayRoll (CommingSoon)".localiz()
//        self.tabBarController?.tabBar.items?[4].title = "more".localiz()
        //
    }
    
    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")
//        self.tabBarController?.tabBar.items?[0].title = "Home".localiz()
//                self.tabBarController?.tabBar.items?[1].title = "Attend".localiz()
//                self.tabBarController?.tabBar.items?[2].title = "Vication (CommingSoon)".localiz()
//                self.tabBarController?.tabBar.items?[3].title = "PayRoll (CommingSoon)".localiz()
//                self.tabBarController?.tabBar.items?[4].title = "more".localiz()
    }
}
