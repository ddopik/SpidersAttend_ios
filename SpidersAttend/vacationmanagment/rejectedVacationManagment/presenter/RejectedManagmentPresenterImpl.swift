//
//  RejectedManagmentPresenterImpl.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/28/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class RejectedManagmentPresenterImpl: RejectedManagmentPresenter {
 
    
       var rejectedManagmentView:RejectedManagmentView!
        
        init(rejectedManagmentView: RejectedManagmentView){
            self.rejectedManagmentView = rejectedManagmentView
        }
        
        
        func getRejectedManagmentVacations(){
            self.rejectedManagmentView.onRejectedManagmentVacationProgress(state: true)
            
            
            
            let succ={ (managmentVacationResponse:ManagmentVacationResponse?)   in
                if let statsId =  managmentVacationResponse?.status {
                    self.rejectedManagmentView.onRejectedManagmentVacationProgress(state: false)
                    self.rejectedManagmentView.viewManagmentRejectedVacations(vacationList: managmentVacationResponse?.data.vacationData ?? [])
                }
            }
            
            let failureClos={
                (err : Any) in
                self.rejectedManagmentView.onRejectedManagmentVacationProgress(state:false)
                
                if (err is NetworkBaseError){
                    self.rejectedManagmentView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                    print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                }else{
                    self.rejectedManagmentView.viewError(msg: "Network Error")
                }
                self.rejectedManagmentView.onRejectedManagmentVacationProgress(state:false)
                
            }
            
            
            
            
       APIRouter.makePostRequest( url :APIRouter.MANAGMENT_REJECTED_VACATION_URL, bodyParameters : ["uid" : PrefUtil.getUserId()!],succese: succ, failure: failureClos as (Any?) -> (), type: ManagmentVacationResponse.self)
            
            
            
        }
        
    
       
}
