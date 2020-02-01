//
//  NavigationManger.swift
//  SpidersAttend
//
//  Created by ddopik on 7/6/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class NavigationManger{
    
    var cuurentStoryBoard: UIStoryboard
    var currentViewController :UIViewController
    var currentQrLocation :CLLocation?
    
    init(storyboard: UIStoryboard,viewController : UIViewController){
        self.cuurentStoryBoard = storyboard
        self.currentViewController = viewController
  
    }
    
    func navigateTo(target :Destinations){
        
        switch target {
        case .SplashScreen :
            
            let splashViewController =   self.cuurentStoryBoard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
            self.currentViewController.present(splashViewController, animated: true, completion: nil)
            
            break
        case .MainScreen :
            
            let mainStateTabNavigationController =   self.cuurentStoryBoard.instantiateViewController(withIdentifier: "MainTabViewController") as! UITabBarController
            self.currentViewController.present(mainStateTabNavigationController, animated: true, completion: nil)
            break
            
        case .Login:
            let loginViewController = cuurentStoryBoard.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
            currentViewController.present(loginViewController, animated: true, completion: nil)
            break
        case .QrScanner:
//        let qrReaderViewController = cuurentStoryBoard.instantiateViewController(withIdentifier: "QrReaderViewController") as! QrReaderViewController
       let qrReaderViewController = QrReaderViewController()
        qrReaderViewController.cuurentQrLocation = self.currentQrLocation
        currentViewController.present(qrReaderViewController, animated: true, completion: nil)
            break
        case .More:
            
            let  moreViewController = self.cuurentStoryBoard.instantiateViewController(withIdentifier: "MoreViewController") as! UITabBarController
            
            self.currentViewController.present(moreViewController, animated: true, completion: nil)
            break
        }
    }
    
    
}

enum Destinations{
    
    case SplashScreen
    case MainScreen
    case Login
    case QrScanner
    case More
}

extension NavigationManger{
    
    func setQrViewControllerMessage(cuurentLocation : CLLocation? )  {
        self.currentQrLocation = cuurentLocation
    }
}
