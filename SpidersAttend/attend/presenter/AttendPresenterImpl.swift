//
//  AttendPresenterImpl.swift
//  SpidersAttend
//
//  Created by ddopik on 12/1/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import CoreLocation

class AttendPresenterImpl: AttendPresenter {
    
    
    
    
    
    
    
    var attendView:AttendView!
    init(attendView:AttendView) {
        self.attendView = attendView
    }
    //
    func requestUserStatus(){
        self.attendView.viewProgress(state: true)
        let succ={ (checkStatusResponse:CheckStatusResponse?)   in
            if let statsId =  checkStatusResponse?.data.attendStatus.status {
                PrefUtil.setCurrentUserStatsID(userStats: statsId)
                self.attendView.setAttendMessageStates(statsID:(checkStatusResponse?.data.attendStatus.status)!)
                print("requestUserStatus()-----> \(String(describing: checkStatusResponse?.data.attendStatus.msg))" )
            }
            self.attendView.viewProgress(state: false)
        }
        let failureClos={
            (err : Any) in
            if (err is NetworkBaseError){
                //                (err:NetworkBaseError?)   in
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                _ = self.attendView.viewDialogMessage( title: "Error", message: ((err as! NetworkBaseError).data?.msg) ?? "failed")
                
                
            }else{
                self.attendView.viewDialogMessage( title: "Error", message: "Network Error")
            }
            
            self.attendView.setAttendBtnState(state: true)
            self.attendView.viewProgress(state: false)
            
        }
        
        let bodyParameter = [
            "uid" : PrefUtil.getUserId()
            ] as! [String : String]
        
        
        APIRouter.makePostRequest(url: APIRouter.CHECK_STATUS_URL, bodyParameters: bodyParameter, succese: succ, failure: failureClos as (Any?) -> (), type: CheckStatusResponse.self)
        
        
        //        do {
        //            try APIRouter.makePostRequest(url: APIRouter.CHECK_STATUS_URL, bodyParameters: bodyParameter, succese: succ, failure: failureClos as! (Any?) -> (), type: CheckStatusResponse.self)
        //        }catch{
        //            let errorObj = error as! ValidationError
        //            self.attendView.viewAlertMessage(title: errorObj.errorTitle, message: errorObj.message)
        //            self.attendView.viewProgress(state: false)
        //        }
        
        
    }
    
    
    /// use this method to verify if user can AttendOrLeave
    /// if user not Ended ---> navigate user According to you logic
    /// in case( attendType == Qr )  ---> Navigate user To Qr screen Reader
    /// in case( attendType == Qr )  ---> Attend user immediatly and update view Stats message
    func sendAttendAction(attendType: AttendMethod, curenrtlocation: CLLocation) {
        
        let succ={ (checkStatusResponse:CheckStatusResponse?)  in
            if let statsId =  checkStatusResponse?.data.attendStatus.status {
                
                
                PrefUtil.setCurrentUserStatsID(userStats: statsId)
                self.attendView.setAttendMessageStates(statsID:(checkStatusResponse?.data.attendStatus.status)!)
                
                if statsId == ApiConstant.ENDED {
                    self.attendView.viewAlertMessage(title: "", message:  (checkStatusResponse?.data.attendStatus.msg)!)
                }else
                    
                    if(attendType == AttendMethod.QR){
                        ////( Attend / Leave ) user through Qr Scanner
                        self.attendView.navigate(dest: NavigationType.QRReader,curenrtlocation: curenrtlocation)
                    }else if(attendType == AttendMethod.NETWORK){
                        /// no need to navigate,  Api response states is Sufficient
                        self.attendView.viewDialogMessage(title: "", message: (checkStatusResponse?.data.attendStatus.msg)!)
                 }
                self.attendView.setAttendBtnState(state: true)
                self.attendView.viewProgress(state: false)
            }
            
        }
        let failureClos={
            (err : Any) in
            if (err is NetworkBaseError){
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                _ = self.attendView.viewDialogMessage( title: "Error", message: ((err as! NetworkBaseError).data?.msg) ?? "failed")
                
            }else{
                self.attendView.viewDialogMessage(title: "Error", message: "Network Error")
            }
            self.attendView.setAttendBtnState(state: true)
            self.attendView.viewProgress(state: false)
            
        }
        let bodyParameter = [
            "uid" : PrefUtil.getUserId()
            ] as! [String : String]
        
        
        if(attendType == AttendMethod.QR){
            APIRouter.makePostRequest(url: APIRouter.CHECK_STATUS_URL, bodyParameters: bodyParameter, succese: succ, failure: failureClos as (Any?) -> (), type: CheckStatusResponse.self)
        }else if(attendType == AttendMethod.NETWORK){
            APIRouter.makePostRequest(url: APIRouter.NETWORK_ATTEND_URL, bodyParameters: bodyParameter, succese: succ, failure: failureClos as (Any?) -> (), type: CheckStatusResponse.self)
        }
        
    }
    
    
}
