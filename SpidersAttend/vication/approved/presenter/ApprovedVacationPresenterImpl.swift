//
//  ApprovedVacationPresenterImpl.swift
//  SpidersAttend
//
//  Created by ddopik on 12/24/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
class ApprovedVacationPresenterImpl: ApprovedVacationPresenter {
    var approvedVacationView:ApprovedVacationView!
    
    init(approvedVacationView:ApprovedVacationView){
        self.approvedVacationView = approvedVacationView
    }
    
    
    func getApprovedVacation() {
         
        self.approvedVacationView.onApprovedVacationProgress(state: true)
        
        
        
        let succ={ (approvedVacationResponse:ApprovedVacationResponse?)   in
            if let statsId =  approvedVacationResponse?.status {
                self.approvedVacationView.onApprovedVacationProgress(state: false)
                self.approvedVacationView.viewApprovedVacations(vacationList: approvedVacationResponse?.data.approvedVacations ?? [])
            }
        }
        
        let failureClos={
            (err : Any) in
            self.approvedVacationView.onApprovedVacationProgress(state:false)
            
            if (err is NetworkBaseError){
                self.approvedVacationView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
            }else{
                self.approvedVacationView.viewError(msg: "Network Error")
            }
            self.approvedVacationView.onApprovedVacationProgress(state:false)
            
        }
        
        
        
        
        let approvedVacationUrl : String = APIRouter.BASE_URL + PrefUtil.getAppLanguage()! + APIRouter.APPROVED_VACATION_URL + PrefUtil.getUserId()!

    

        APIRouter.makeGetRequest( currentUrl: approvedVacationUrl , succese: succ, failure: failureClos as (Any?) -> (), type: ApprovedVacationResponse.self)
        
        
        
    }
}
