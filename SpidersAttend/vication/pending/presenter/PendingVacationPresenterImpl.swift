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
    
    func deletePendingVacation() {
        
    }
    
    }
 

    


