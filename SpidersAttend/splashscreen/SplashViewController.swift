//
//  SplashViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/16/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let next = self.storyboard!.instantiateViewController(withIdentifier: "loginViewController") as! LoginViewController
            
            
            self.present(next, animated: true, completion: nil)        })
    }
}
