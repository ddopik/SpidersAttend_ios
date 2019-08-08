//
//  AttendViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 8/7/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit

class AttendViewController: GeotificationBaseViewController {
    
    
    @IBOutlet weak var stateMessage: UITextView!
    @IBOutlet weak var qrAttendButton: UIButton!
    @IBOutlet weak var statsMessage : UITextView!
    


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        super.onLocationFencingUpdate=self
         requestUserStatus()
        
    }
    @IBAction func qrAttendButton(_ sender: Any) {
        super.onLocationUpdateDelegate = self
        setAttendBtnState(state:false)
        requestAttendAction()
        
    }
    
    
    
    func setAttendBtnState(state :Bool){
        if !state{
            qrAttendButton.backgroundColor = .gray
            qrAttendButton.isEnabled=false
        }else{
            qrAttendButton.backgroundColor = .blue
            qrAttendButton.isEnabled=true
        }
        
    }
}

extension AttendViewController{
    
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
            try APIRouter.makePostRequesr(url: APIRouter.CHECK_STATUS_URL, bodyParameters: bodyParameter, succese: succ, failure: failureClos as! (Any?) -> (), type: CheckStatusResponse.self)
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
            try _ =  APIRouter.makePostRequesr(url: APIRouter.CHECK_STATUS_URL, bodyParameters: bodyParameter, succese: succ, failure: failureClos as! (Any?) -> (), type: CheckStatusResponse.self)
        }catch{
            let errorObj = error as! ValidationError
            showAlert(withTitle: errorObj.errorTitle, message: errorObj.message)
        }
    }
}

extension AttendViewController : OnLocationFencingUpdate {
    
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
