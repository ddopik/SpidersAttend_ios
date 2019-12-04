//
//  CustomTabBarController.swift
//  SpidersAttend
//
//  Created by ddopik on 12/3/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import SwiftUI
 class CustomTabBarController: UITabBarController {

    @IBOutlet weak var tabTest: UITabBar!
    
  override func viewDidLoad() {
      super.viewDidLoad()
      // I've added this line to viewDidLoad
 
  }
    override func viewDidLayoutSubviews()
    {
           UIApplication.shared.statusBarFrame.size.height
        tabTest.frame = CGRect(x: 0, y:  0, width: tabTest.frame.size.width, height:tabTest.frame.size.height)
      
        UITabBarItem.appearance()
        .setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont(name: "Didot", size: 40)!],
        for: .normal)
    }
    ;
}
