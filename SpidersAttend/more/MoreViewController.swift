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
        tableItems.append(getString(stringKey: "language"))
        tableItems.append( getString(stringKey: "logout"))
        
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
        let dialogMessage = UIAlertController(title: getString(stringKey: "Choose language"), message: "", preferredStyle: .alert)
        
        // Create OK button with action handler
        let arabic = UIAlertAction(title: getString(stringKey: "Arabic"), style: .default, handler: { (action) -> Void in
            LanguageDetails().changeLanguage()
            NavigationManger(storyboard: self.storyboard!, viewController: self).navigateTo(target : Destinations.MainScreen)
        })
        
        // Create Cancel button with action handlder
        let english = UIAlertAction(title: getString(stringKey: "ِEnglish"), style: .cancel) { (action) -> Void in
            LanguageDetails().changeLanguage()
            NavigationManger(storyboard: self.storyboard!, viewController: self).navigateTo(target : Destinations.MainScreen)
        }
//        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(arabic)
        dialogMessage.addAction(english)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
}
    
   
