//
//  MoreViewController.swift
//  SpidersAttendm
//
//  Created by ddopik on 7/6/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moreTableView: UITableView!
    
    
    var tableItems : [String]=[]
 
   
 
     override func viewDidLoad() {
        super.viewDidLoad()
 
//        self.tabBarController?.tabBar.items?[0].title = "Home".localiz()
//        self.tabBarController?.tabBar.items?[4].title = "more".localiz()
        
        tableItems.append("language".localiz())
        tableItems.append( "logout".localiz())
        
        self.moreTableView.register(UITableViewCell.self, forCellReuseIdentifier: "moreCell")
        moreTableView.delegate = self
        moreTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("------> cellForRowAt")
        
        let cell :UITableViewCell = (self.moreTableView?.dequeueReusableCell(withIdentifier: "moreCell"))!
        cell.selectionStyle = UITableViewCell.SelectionStyle.blue
        let cellBGView = UIView()
        cellBGView.backgroundColor = UIColor(red: 0, green: 0, blue: 200, alpha: 0.4);
        cell.selectedBackgroundView = cellBGView
        cell.textLabel?.text=tableItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        
        if (indexPath.row == 1){
            
            let succClosh={
                super.stopLocationManger()
                PrefUtil.clearPrefUtil()
                NavigationManger(storyboard : self.storyboard!, viewController:  self).navigateTo(target: Destinations.SplashScreen)
            }
            
            let failClosh = {
                
            }
            
            super.showOptionalConfirmDialog(failure: failClosh, succese: succClosh, title: getString(stringKey: "Confirm"), description: getString(stringKey: "are you sure you want to Logout ?"))
        }else if(indexPath.row == 0){
         showChooseLanguageDialog()
        }
        
    }
    
    
    
    
    func showChooseLanguageDialog() {
        let dialogMessage = UIAlertController(title: getString(stringKey: "Choose language"), message: "", preferredStyle: .actionSheet)
        
        
         let arabic = UIAlertAction(title:   "Arabic".localiz(), style: .default, handler: { (action) -> Void in
            PrefUtil.setAppLang(appLang: PrefUtil.ARABIC_LANG)
            LanguageManager.shared.setLanguage(language: .ar, rootViewController: self.storyboard?.instantiateInitialViewController(), animation: nil )
        })
        
        // Create Cancel button with action handlder
        let english = UIAlertAction(title: "ِEnglish".localiz(), style: .default) { (action) -> Void in
            PrefUtil.setAppLang(appLang: PrefUtil.ENGLISH_LANG)
           LanguageManager.shared.setLanguage(language: .en, rootViewController: self.storyboard?.instantiateInitialViewController(), animation: nil )

        }
//        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(arabic)
        dialogMessage.addAction(english)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissAlertController))
            dialogMessage.view.superview?.subviews[0].addGestureRecognizer(tapGesture)
        }
        
       
        
    }
    
    @objc func dismissAlertController(){
        self.dismiss(animated: true, completion: nil)
    }
}
    
   
