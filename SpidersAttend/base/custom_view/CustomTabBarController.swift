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
 UITabBarItem.appearance()
 .setTitleTextAttributes(
     [NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size:   16)!],
 for: .normal)
    
     
  }
    override func viewDidLayoutSubviews()
    {
 
        
          tabTest.frame = CGRect(x: 0, y:  0, width: tabTest.frame.size.width, height:tabTest.frame.size.height)
      
        tabTest.itemPositioning = UITabBar.ItemPositioning.fill
        
     }
    ;
}
