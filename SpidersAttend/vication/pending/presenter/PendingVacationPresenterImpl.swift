//
//  PendingVacationImpl.swift
//  SpidersAttend
//
//  Created by ddopik on 12/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation

class PendingVacationPresenterImpl:PendingVacationPresenter {
    
    
    
    
    var pendingVacationView:PendingVacationView!
    
    init(pendingVacationView: PendingVacationView){
        self.pendingVacationView = pendingVacationView
    }
    
    
    func getPendingVacations(){
        self.pendingVacationView.onPendingVacationProgress(state: true)
        
        
        
        let succ={ (pendingVacationResponse:PendingVacationResponse?)   in
            if let statsId =  pendingVacationResponse?.status {
                self.pendingVacationView.onPendingVacationProgress(state: false)
                self.pendingVacationView.viewPendingVacations(vacationList: pendingVacationResponse?.data.pendingVacations ?? [])
            }
        }
        
        let failureClos={
            (err : Any) in
            self.pendingVacationView.onPendingVacationProgress(state:false)
            
            if (err is NetworkBaseError){
                self.pendingVacationView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
            }else{
                self.pendingVacationView.viewError(msg: "Network Error")
            }
            self.pendingVacationView.onPendingVacationProgress(state:false)
            
        }
        
        
        
        
        
        
        APIRouter.getPendingVacations( userId: PrefUtil.getUserId()!, succese: succ, failure: failureClos as (Any?) -> (), type: PendingVacationResponse.self)
        
        
        
    }
    
    func deletePendingVacation(vacation: Vacation, indexPath: IndexPath){
        self.pendingVacationView.onPendingVacationProgress(state: true)
               
               
               
               let succ={ (deletePendingVacationResponse:DeletePendingVacationResponse?)   in
                   if let statsId =  deletePendingVacationResponse?.status {
                       self.pendingVacationView.onPendingVacationProgress(state: false)
                    self.pendingVacationView.onPendingVacationDeleted(vacation: vacation, indexPath: indexPath, state: true)
                   }
               }
               
               let failureClos={
                   (err : Any) in
                   self.pendingVacationView.onPendingVacationProgress(state:false)
                   
                   if (err is NetworkBaseError){
                       self.pendingVacationView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                       print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                   }else{
                       self.pendingVacationView.viewError(msg: "Network Error")
                   }
                   self.pendingVacationView.onPendingVacationProgress(state:false)
                   
               }
               
               
               
               
        let apiParameter = [APIRouter.UID_BODY_PARAMETER  : PrefUtil.getUserId()!,APIRouter.VACATION_ID_BODY_PARAMETER : vacation.id]
               
        APIRouter.makePostRequest(url:APIRouter.DELETE_PENDING_VACATION_URL+vacation.id, bodyParameters: apiParameter, succese: succ, failure: failureClos as (Any?) -> (), type: DeletePendingVacationResponse.self)
    }
    
}





