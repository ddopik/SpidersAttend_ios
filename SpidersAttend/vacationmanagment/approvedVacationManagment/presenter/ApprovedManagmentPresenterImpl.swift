//
//  ApprovedManagmentPresenterImpl.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/27/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class ApprovedManagmentPresenterImpl: ApprovedManagmentPresenter {
    
    var approvedManagmentView:ApprovedManagmentView!
     
     init(approvedManagmentView: ApprovedManagmentView){
         self.approvedManagmentView = approvedManagmentView
     }
     
     
     func getApprovedManagmentVacations(){
         self.approvedManagmentView.onApprovedManagmentVacationProgress(state: true)
         
         
         
         let succ={ (managmentVacationResponse:ManagmentVacationResponse?)   in
             if let statsId =  managmentVacationResponse?.status {
                 self.approvedManagmentView.onApprovedManagmentVacationProgress(state: false)
                 self.approvedManagmentView.viewManagmentApprovedVacations(vacationList: managmentVacationResponse?.data.vacationData ?? [])
             }
         }
         
         let failureClos={
             (err : Any) in
             self.approvedManagmentView.onApprovedManagmentVacationProgress(state:false)
             
             if (err is NetworkBaseError){
                 self.approvedManagmentView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                 print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
             }else{
                 self.approvedManagmentView.viewError(msg: "Network Error")
             }
             self.approvedManagmentView.onApprovedManagmentVacationProgress(state:false)
             
         }
         
         
         
         
         
         
      APIRouter.makePostRequest( url :APIRouter.MANAGMENT_APPROVED_VACATION_URL, bodyParameters : ["uid" : PrefUtil.getUserId()!],succese: succ, failure: failureClos as (Any?) -> (), type: ManagmentVacationResponse.self)
         
         
         
     }
     
 
    
}
