//
//  RejectedVacationPresenterImpl.swift
//  SpidersAttend
//
//  Created by ddopik on 12/25/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation

class RejectedVacationPresenterImpl: RejectedVacationPresenter {
    
    var rejectedControllerView:RejectedVacationControllerView!

    init(rejectedControllerView:RejectedVacationControllerView!) {
        self.rejectedControllerView = rejectedControllerView
    }
    
    func getRejectedVacation() {

            self.rejectedControllerView.onRejectedVacationProgress(state: true)
            
            
            
            let succ={ (rejectedVacationResponse:RejectedVacationResponse?)   in
                if let statsId =  rejectedVacationResponse?.status {
                    self.rejectedControllerView.onRejectedVacationProgress(state: false)
                    self.rejectedControllerView.viewRejectedVacations(vacationList: rejectedVacationResponse?.data.rejectedVacations ?? [])
                }
            }
            
            let failureClos={
                (err : Any) in
                self.rejectedControllerView.onRejectedVacationProgress(state:false)
                
                if (err is NetworkBaseError){
                    self.rejectedControllerView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                    print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                }else{
                    self.rejectedControllerView.viewError(msg: "Network Error")
                }
                self.rejectedControllerView.onRejectedVacationProgress(state:false)
                
            }
            
            
            
            
            let rejectedVacationUrl : String = APIRouter.BASE_URL + PrefUtil.getAppLanguage()! + APIRouter.REJECTED_VACATION_URL + PrefUtil.getUserId()!

        

            APIRouter.makeGetRequest( currentUrl: rejectedVacationUrl , succese: succ, failure: failureClos as (Any?) -> (), type: RejectedVacationResponse.self)
    }
}
