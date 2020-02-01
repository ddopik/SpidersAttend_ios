//
//  PendingManagmentVacationPresenterImpl.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/27/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation

class PendingManagmentVacationPresenterImpl :PendingManagmentVacationPresenter {

    
    var pendingManagmentView:PendingManagmentView!
    
    init(pendingManagmentView: PendingManagmentView){
        self.pendingManagmentView = pendingManagmentView
    }
    
    
    func getPendingManagmentVacations(){
        self.pendingManagmentView.onPendingManagmentVacationProgress(state: true)
        
        
        
        let succ={ (managmentVacationResponse:ManagmentVacationResponse?)   in
            if (managmentVacationResponse?.status) != nil {
                self.pendingManagmentView.onPendingManagmentVacationProgress(state: false)
                self.pendingManagmentView.viewManagmentPendingVacations(vacationList: managmentVacationResponse?.data.vacationData ?? [])
            }
        }
        
        let failureClos={
            (err : Any) in
            self.pendingManagmentView.onPendingManagmentVacationProgress(state:false)
            
            if (err is NetworkBaseError){
                self.pendingManagmentView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
            }else{
                self.pendingManagmentView.viewError(msg: "Network Error")
            }
            self.pendingManagmentView.onPendingManagmentVacationProgress(state:false)
            
        }
        
        
        
        
        
        
        APIRouter.makePostRequest( url :APIRouter.MANAGMENT_PENDING_VACATION_URL, bodyParameters : ["uid" : PrefUtil.getUserId()!],succese: succ, failure: failureClos as (Any?) -> (), type: ManagmentVacationResponse.self)
        
        
        
    }
    
    func rejectPendingVacation(vacation: Vacation,vacationReason:String){
        self.pendingManagmentView.onPendingManagmentVacationProgress(state: true)
               
               
               
               let succ={ (rejectPendingVacationResponse: RejectPendingVacationResponse?)   in
                if (rejectPendingVacationResponse?.status) != nil {
                       self.pendingManagmentView.onPendingManagmentVacationProgress(state: false)
                      self.pendingManagmentView.onPendingManagmentVacationRejected(vacation: vacation, state: true)
                   }
               }
               
               let failureClos={
                   (err : Any) in
                   self.pendingManagmentView.onPendingManagmentVacationProgress(state:false)
                   
                   if (err is NetworkBaseError){
                       self.pendingManagmentView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                       print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                   }else{
                       self.pendingManagmentView.viewError(msg: "Network Error")
                   }
                   self.pendingManagmentView.onPendingManagmentVacationProgress(state:false)
                   
               }
               
               
               
               
        let apiParameter = [APIRouter.UID_BODY_PARAMETER  : PrefUtil.getUserId()!,APIRouter.VACATION_ID_BODY_PARAMETER : vacation.id,APIRouter.REASON_BODY_PARAMETER :vacationReason]
               
        APIRouter.makePostRequest(url:APIRouter.REJECT_PENDING_VACATION_URL, bodyParameters: apiParameter, succese: succ, failure: failureClos as (Any?) -> (), type: RejectPendingVacationResponse.self)
    }
    
    func approvePendingVacation(vacation: Vacation) {

                self.pendingManagmentView.onPendingManagmentVacationProgress(state:true)

                let succ={ (managmentVacationApproveResponse:ManagmentVacationApproveResponse?)   in
                    if let statsId =  managmentVacationApproveResponse?.status {
                        self.pendingManagmentView.onPendingManagmentVacationProgress(state: false)
                        self.pendingManagmentView.onPendingManagmentVacationApproved(vacation: vacation, state: true)
                    }
                }
                
                let failureClos={
                    (err : Any) in
                    self.pendingManagmentView.onPendingManagmentVacationProgress(state:false)
                    
                    if (err is NetworkBaseError){
                        self.pendingManagmentView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                        print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                    }else{
                        self.pendingManagmentView.viewError(msg: "Network Error")
                    }
                    self.pendingManagmentView.onPendingManagmentVacationProgress(state:false)
                    
                }
                
                
                
                
        let apiParameter = [APIRouter.UID_BODY_PARAMETER  : PrefUtil.getUserId()! ,APIRouter.VACATION_ID_BODY_PARAMETER : vacation.id]

         APIRouter.makePostRequest(url:APIRouter.APPROVE_PENDING_VACATION_URL, bodyParameters: apiParameter, succese: succ, failure: failureClos as (Any?) -> (), type: ManagmentVacationApproveResponse.self)
    }
    
  
    
}
