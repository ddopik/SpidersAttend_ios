//
//  MainStateViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 6/26/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit
import CoreLocation


class MainStateViewController :GeotificationBaseViewController {
    
    @IBOutlet weak var clockView: ClockView!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var stateMessage: UITextView!
    @IBOutlet weak var attendBtn: UIButton!
    
    
    
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
 
    
       
        self.tabBarController?.tabBar.items?[0].title = "Home".localiz()
        self.tabBarController?.tabBar.items?[1].title = "Attend".localiz()
        self.tabBarController?.tabBar.items?[2].title = "Vication".localiz()
         self.tabBarController?.tabBar.items?[3].title = "PayRoll".localiz()
         self.tabBarController?.tabBar.items?[4].title = "more".localiz()
        
         attendBtn.setTitle("Attend".localiz(), for: .normal)
 
        
 
//        self.tabBarController?.tabBar.setBadge(value: "Soon".localiz(), at: ((self.tabBarController?.tabBar.items!.count)!) - 3)
//        self.tabBarController?.tabBar.setBadge(value: "Soon".localiz(), at:  ((self.tabBarController?.tabBar.items!.count)!) - 2)

    }
    private func adjustTabBarText(textSize:CGFloat){
        
        let itemCount =   (self.tabBarController?.tabBar.items!.count)! - 1
        
        for index in (0...itemCount ){
            self.tabBarController?.tabBar.items?[index].setBadgeTextAttributes([
                NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: textSize)!
                 ],for: .normal)
        }
    }
    

    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        super.onLocationFencingUpdate=self
        setCloclView()
        requestUserStatus()
        
    }
    
    @IBAction func attendButton(_ sender: Any) {
        super.onLocationUpdateDelegate = self
        
        setAttendBtnState(state:false)
        requestAttendAction()
        
    }
    
    
    
    
    func setAttendBtnState(state :Bool){
        if !state{
            attendBtn.backgroundColor = .gray
            attendBtn.isEnabled=false
        }else{
            attendBtn.backgroundColor = .blue
            attendBtn.isEnabled=true
        }
        
    }
    
    
    @objc  func appMovedToForeground() {
        print("App moved to ForeGround!")
        
        requestUserStatus()
        
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

////////////////////////////////////





extension MainStateViewController{
    
    func requestUserStatus(){
        startProgress()
        let succ={ (checkStatusResponse:CheckStatusResponse?)   in
            if let statsId =  checkStatusResponse?.data.attendStatus.status {
                PrefUtil.setCurrentUserStatsID(userStats: statsId)
                self.stateMessage.text=checkStatusResponse?.data.attendStatus.msg
                print("requestUserStatus()-----> \(checkStatusResponse?.data.attendStatus.msg)" )
            }
            self.stopProgress()
        }
        let failureClos={
            
            //            (err:NetworkBaseError?) in
            //            print("failed ---->\(String(describing: err?.data?.msg))")
            //            _ = self.showSimpleConfirmDialog(parent: self, messageText: (err?.data?.msg) ?? "failed",messageTitle: "Error", buttonText: "Ok")
            //            self.stopProgress()
            (err : Any) in
            if (err is NetworkBaseError){
                //                (err:NetworkBaseError?)   in
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                _ = self.showSimpleConfirmDialog(parent: self, messageText: ((err as! NetworkBaseError).data?.msg) ?? "failed",messageTitle: "Error", buttonText: "Ok")
                ///disaple progressView here
                
                
            }else{
                _ = self.showSimpleConfirmDialog(parent: self, messageText: "Network Error",messageTitle: "Error", buttonText: "Ok")
            }
            
            self.setAttendBtnState(state: true)
            self.stopProgress()
            
        }
        
        let bodyParameter = [
            "uid" : PrefUtil.getUserId()
            ] as! [String : String]
        do {
            try APIRouter.makePostRequest(url: APIRouter.CHECK_STATUS_URL, bodyParameters: bodyParameter, succese: succ, failure: failureClos as! (Any?) -> (), type: CheckStatusResponse.self)
        }catch{
            let errorObj = error as! ValidationError
            showAlert(withTitle: errorObj.errorTitle, message: errorObj.message)
            self.stopProgress()
        }
        
        
    }
    
    
    
    
    ////////////////////////
    func requestAttendAction(){
        startProgress()
        let succ={ (checkStatusResponse:CheckStatusResponse?)  in
            
            print("requestAttendAction()-----> \(checkStatusResponse?.data.attendStatus.msg) with id = \(checkStatusResponse?.data.attendStatus.status)" )
            
            if let statsId =  checkStatusResponse?.data.attendStatus.status {
                PrefUtil.setCurrentUserStatsID(userStats: statsId)
                self.stateMessage.text=checkStatusResponse?.data.attendStatus.msg
                
                if statsId == ApiConstant.ENDED {
                    super.showAlert(withTitle: "Warrning", message:  checkStatusResponse?.data.attendStatus.msg)
                    self.setAttendBtnState(state: true)
                    self.stopProgress()
                    return
                }
                
                do{
                    //step ->1
                    /*
                     start location Updater and region Fencing
                     */
                    try self.startLocationServices()
                }
                catch{
                    print("MainStateViewController ----> \(Error.self)")
                    self.setAttendBtnState(state: true)
                    self.stopProgress()
                }
                
                
                
            }
            
        }
        let failureClos={
            (err : Any) in
            if (err is NetworkBaseError){
                //                (err:NetworkBaseError?)   in
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                _ = self.showSimpleConfirmDialog(parent: self, messageText: ((err as! NetworkBaseError).data?.msg) ?? "failed",messageTitle: "Error", buttonText: "Ok")
                ///disaple progressView here
                
                
            }else{
                _ = self.showSimpleConfirmDialog(parent: self, messageText: "Network Error",messageTitle: "Error", buttonText: "Ok")
            }
            self.setAttendBtnState(state: true)
            self.stopProgress()
            
        }
        let bodyParameter = [
            "uid" : PrefUtil.getUserId()
            ] as! [String : String]
        
        
        do {
             try _ =  APIRouter.makePostRequest(url: APIRouter.CHECK_STATUS_URL, bodyParameters: bodyParameter, succese: succ, failure: failureClos as! (Any?) -> (), type: CheckStatusResponse.self)
        }catch{
            let errorObj = error as! ValidationError
            showAlert(withTitle: errorObj.errorTitle, message: errorObj.message)
        }
    }
}




extension MainStateViewController : OnLocationFencingUpdate {
    
    func onDestanceGetMeasured(destance: Double) {
        print("destance is ----> \(destance) ")
        
        self.setAttendBtnState(state: true)
        self.stopProgress()
        
        
        if( PrefUtil.getCurrentCentralRadius()! >= destance  ){
            
            let navigationManger = NavigationManger(storyboard: self.storyboard!,viewController: self)
            navigationManger.setQrViewControllerMessage(cuurentLocation: super.locationManager.location)
            navigationManger.navigateTo(target :Destinations.QrScanner)
        } else{
            showAlert(withTitle: "Error", message: "you are out of area")
            
        }
        
        
    }
    
    func onUserInside() {
        //        self.setAttendBtnState(state: true)
        //        self.stopProgress()
        
    }
    
    func onUserOutside() {
        //        self.setAttendBtnState(state: true)
        //        self.stopProgress()
        //        showAlert(withTitle: "alert", message: "you are out side")
    }
    
    func onUserWithUnKnowenFencing() {
        //        self.setAttendBtnState(state: true)
        //        self.stopProgress()
        //        showAlert(withTitle: "alert", message: "UnKnowen Area")
    }
    
    
    
}

