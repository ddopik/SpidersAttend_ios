//
//  MainStateViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/26/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit
import CoreLocation


class MainStateViewController :BaseViewController,MainStateView {
    
    
    
    
    
    
   
    
    
 
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var stateMessage: UITextView!
    var vacationManagmentViewController:VacationManagmentTabBarController!
    var mainStatePresenter: MainStatePresenter!
    
    @IBOutlet var tapGetureRecognizer: UITapGestureRecognizer!
    private var timer: Timer!
    private var timeToDisplay: Date? {
        willSet {
            guard let newDate = newValue else { return }
            updateView(newDate: newDate)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainStatePresenter = MainStatePresenterImpl(mainStateView: self)
        self.tabBarController?.tabBar.items?[0].title = "Home".localiz()
        self.tabBarController?.tabBar.items?[1].title = "Attend".localiz()
        self.tabBarController?.tabBar.items?[2].title = "Vication".localiz()
        self.tabBarController?.tabBar.items?[3].title = "PayRoll".localiz()
        self.tabBarController?.tabBar.items?[4].title = "edit".localiz()
        self.tabBarController?.tabBar.items?[4].title = "Vacation Managment".localiz()

        vacationManagmentViewController = tabBarController?.viewControllers?[5] as? VacationManagmentTabBarController

        adjustTabBarText(textSize: FONTS.MAIN_TAB_BAR_FONT_SIZE)
        
    }
    
    
    
    
    private func adjustTabBarText(textSize:CGFloat){
        let appearance = UITabBarItem.appearance()
               let attributes: [NSAttributedString.Key: AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue):UIFont(name: "American Typewriter", size: textSize)!]
               appearance.setTitleTextAttributes(attributes, for: .normal)

 
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCloclView()
        mainStatePresenter.requestUserStatus()
        mainStatePresenter.getUserManagmentStats()
   
        
    }
    
    
    
    
    
    func viewProgress(state: Bool) {
        if(state){
            startProgress()
        }else{
            stopProgress()
        }
    }
    
    func viewUserStatsMessage(userStatsMessage:String){
        self.stateMessage.text  = userStatsMessage
    }
    
    /*
     * Handle vacation managment visabilty
     */
    func setManagmentControll(state: Bool) {
        tabBarController?.viewControllers?.count
        if(!state){
            if ( tabBarController?.viewControllers?.count ?? 0 >= 6 )
            {
                tabBarController?.viewControllers?[4].title = "edit".localiz()
               tabBarController?.viewControllers?.removeLast()
            }
        }
            else {
                if  (tabBarController?.viewControllers?.count ?? 0 <= 5) {
                    tabBarController?.viewControllers?.append(vacationManagmentViewController)
                    tabBarController?.viewControllers?[4].title = "edit".localiz()
                    tabBarController?.viewControllers?[5].title = "Vacation Managment".localiz()

                }

            }
        
        
    }
    func showMessage(withTitle title: String?, message: String?) {
        showAlert(withTitle: title, message: message)
    }
    
    func viewDialogMessage(title: String, message: String) {
        self.showSimpleConfirmDialog(parent: self, messageText: message,messageTitle: title, buttonText: "Ok")
    }
    
    
    @objc  func appMovedToForeground() {
        print("App moved to ForeGround!")
        mainStatePresenter.requestUserStatus()
    }
    
    
    
    @objc func willEnterForeground() {
        print("App moved to Background!")
    }
    
}
/////////////////////////////////////////////////

extension MainStateViewController{
    
    
    private func setCloclView(){
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateAction), userInfo: nil, repeats: true)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        // if timeToDisplay is nil, set it and return
        // otherwise it was set by a different controller
        guard let _ = timeToDisplay else {
            timeToDisplay = updateNow()
            return
        }
        
    }
    
    @objc
    @IBAction func updateAction(_ sender: Any) {
        timeToDisplay = updateNow()
    }
    
    func updateNow() -> Date {
        return Date()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        clockView = nil
        timer.invalidate()
        timer = nil
    }
    func updateView(newDate: Date) {
        clockView?.timeToDisplay = newDate
        dateTimeLabel?.text = newDate.asDateTimeString()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
}


