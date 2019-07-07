//
//  SplashViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/16/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
 
  override  func viewDidLoad() {
        super.viewDidLoad()
    print("SplashViewController  ----> viewDidLoad()")
    
    
     DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
         if  PrefUtil.isLoggedIn(){
 
            NavigationManger(storyboard: self.storyboard!, viewController: self).navigateTo(target: Destinations.MainScreen)
         }else{


                NavigationManger(storyboard: self.storyboard!, viewController: self).navigateTo(target: Destinations.Login)


        }
    })
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    
    }
}
