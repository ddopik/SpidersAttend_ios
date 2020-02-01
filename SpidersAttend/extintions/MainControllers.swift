//
//  MainControllers.swift
//  SpidersAttend
//
//  Created by ddopik on 1/16/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
extension BaseViewController{
    
    func showSimpleConfirmDialog(parent: UIViewController, messageText: String, messageTitle: String, buttonText: String) -> UIAlertController {
        let alert = UIAlertController(title: messageTitle, message: messageText, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.cancel, handler: nil))
        parent.present(alert, animated: true)
        return alert
    }
    
    func showSimpleConfirmDialog(parent: UIViewController, messageText: String, messageTitle: String, buttonText: String, onCompl :@escaping ()-> Void  ) -> UIAlertController {
        let alert = UIAlertController(title: messageTitle, message: messageText, preferredStyle: UIAlertController.Style.alert)
    
        alert.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.cancel, handler: { action in  _ = onCompl  }))
      
        parent.present(alert, animated: true)
        return alert
    }
    
    func showOptionalConfirmDialog(failure :@escaping ()-> Void , succese :@escaping ()-> Void,title :String,description
        : String ){
        let dialogMessage = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            succese()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            failure()
        }
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    
}
 
