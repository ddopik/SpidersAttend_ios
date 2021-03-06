//
//  NewVacationControllerImpl.swift
//  SpidersAttend
//
//  Created by ddopik on 1/2/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class NewVacationControllerPresenterImpl :NewVacationControllerPresenter{
    
    
    var newVacationControllerView : NewVacationControllerView!
    init (newVacationControllerView : NewVacationControllerView){
        self.newVacationControllerView =  newVacationControllerView
    }
    
    func getVacationData() {
        
        
        self.newVacationControllerView.viewProgress(state: true)
        
        
        
        let succ={ (newVacationDataResponse:NewVacationDataResponse?)   in
            if let statsId =  newVacationDataResponse?.status {
                self.newVacationControllerView.viewProgress(state: false)
                self.newVacationControllerView.setManagersList(managersList: (newVacationDataResponse?.data.users)!)
                self.newVacationControllerView.setVacationTypes(vacationTypes: (newVacationDataResponse?.data.vacationsType)!)
                
                
            }
        }
        
        let failureClos={
            (err : Any) in
            self.newVacationControllerView.viewProgress(state:false)
            
            if (err is NetworkBaseError){
                self.newVacationControllerView.viewError(title:"Error".localiz(),body:((err as! NetworkBaseError).data?.msg) ?? "failed")
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
            }else{
                self.newVacationControllerView.viewError(title:"Error".localiz(),body: "Network Error".localiz())
            }
            self.newVacationControllerView.viewProgress(state:false)
            
        }
        
        
        
        
        let url : String = APIRouter.BASE_URL + PrefUtil.getAppLanguage()! + APIRouter.NEW_VACATION_FORM_DATA_URL
        
        APIRouter.makeGetRequest(getUrl:url , succese: succ, failure: failureClos as (Any?) -> (), type: NewVacationDataResponse.self)
        
        
        
    }
    
    
    
    func sendNewVacationRequest(newVacationObj:NewVacationObj) {
        
        self.newVacationControllerView.viewProgress(state: true)
        
        
        
        let succ={ (vacationRequestResponse:VacationRequestResponse?)   in
            if let _ =  vacationRequestResponse?.status {
                self.newVacationControllerView.viewProgress(state: false)
                self.newVacationControllerView.onVacationCreated(state:true)
                
            }
        }
        
        let failureClos={
            (err : Any) in
            self.newVacationControllerView.viewProgress(state:false)
            
            if (err is NetworkBaseError){
                self.newVacationControllerView.viewError(title:"Error".localiz(),body:((err as! NetworkBaseError).data?.msg) ?? "failed")
                print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
            }else{
                self.newVacationControllerView.viewError(title:"Error".localiz(),body: "Network Error".localiz())
            }
            self.newVacationControllerView.viewProgress(state:false)
            
        }
        
        
        let parameter :[String:String]=["uid":PrefUtil.getUserId()!,"reason":newVacationObj.vacationReason,"start_date":newVacationObj.vacationStartDate,"end_date":newVacationObj.vacationEndDate,"request_to":newVacationObj.vacationManager,"vacations_type_id":newVacationObj.vacationType]
        let currentUrl : String = APIRouter.NEW_VACATION_REQUEST_URL
        
         APIRouter.makePostRequest(url:currentUrl,bodyParameters:parameter , succese: succ, failure: failureClos as (Any?) -> (), type: VacationRequestResponse.self)
        
    }
    
    
    
    
}
