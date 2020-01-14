//
//  PayRollPresenterImpl.swift
//  SpidersAttend
//
//  Created by ddopik on 1/12/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class PayRollPresenterImp:PayRollPresenter{
    
    private var payRollViewControllerView:PayRollViewControllerView!
    
    init(payRollViewControllerView:PayRollViewControllerView){
        self.payRollViewControllerView = payRollViewControllerView
    }
    
    func getPayRollData() {
        self.payRollViewControllerView.viewProgress(state: true)

        
        let succ={ (payrollRequestResponse:PayrollRequestResponse?)   in
            self.payRollViewControllerView.viewProgress(state: false)

            if let _ =  payrollRequestResponse?.status {
                self.payRollViewControllerView.viewPayRoll(payRollList: payrollRequestResponse?.data.payroll ?? [Payroll]())
             }
        }
        
        let failureClos={
            (err : Any) in
            self.payRollViewControllerView.viewProgress(state:false)
            
            if (err is NetworkBaseError){
                self.payRollViewControllerView.viewError(msg:((err as! NetworkBaseError).data?.msg) ?? "failed")
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
            }else{
                self.payRollViewControllerView.viewError(msg: "Network Error")
            }
            self.payRollViewControllerView.viewProgress(state:false)
            
        }
        
        
        let parameter = [ "uid":PrefUtil.getUserId()!]
        
        
        
        APIRouter.makePostRequest( url: APIRouter.PAY_ROLL_DATA_URL,bodyParameters: parameter, succese: succ, failure: failureClos as (Any?) -> (), type: PayrollRequestResponse.self)
        
        
    }
    
}
