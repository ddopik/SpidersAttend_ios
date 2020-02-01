//
//  VacationManagmentTabBarController.swift
//  SpidersAttend
//
//  Created by ddopik on 1/22/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class VacationManagmentTabBarController :UITabBarController {
    
    let tabTitle :String = "Vacation Managment".localiz()
    
    @IBOutlet weak var managmentTabBarItem: UITabBarItem!
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
}
class MangamentTabBar: UITabBar {

//   override public func sizeThatFits(_ size: CGSize) -> CGSize {
//        super.sizeThatFits(size)
//
//
//        var sizeThatFits = super.sizeThatFits(size)
//        sizeThatFits.height += 10 ;
//        return sizeThatFits
//    }
//

}
