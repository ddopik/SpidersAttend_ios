//
//  MainStatePresenterImpl.swift
//  SpidersAttend
//
//  Created by ddopik on 12/1/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation

class MainStatePresenterImpl:MainStatePresenter{
 
    
    
    var mainStateView:MainStateView!
 
    init(mainStateView: MainStateView){
        self.mainStateView = mainStateView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
        func requestUserStatus(){
            self.mainStateView.viewProgress(state: true)
            
            
              let succ={ (checkStatusResponse:CheckStatusResponse?)   in
                  if let statsId =  checkStatusResponse?.data.attendStatus.status {
                      PrefUtil.setCurrentUserStatsID(userStats: statsId)
 
                    self.mainStateView.viewUserStatsMessage(userStatsMessage :(checkStatusResponse?.data.attendStatus.msg)!)
                    print("requestUserStatus()-----> \(String(describing: checkStatusResponse?.data.attendStatus.msg))" )
                  }
                self.mainStateView.viewProgress(state: false)
              }
            
            
              let failureClos={
                  (err : Any) in
                  if (err is NetworkBaseError){
                      //                (err:NetworkBaseError?)   in
                      print("failed ---->\(String(describing: (err as! NetworkBaseError).data?.msg))")
                    self.mainStateView.viewDialogMessage(title:"Error",message:((err as! NetworkBaseError).data?.msg) ?? "failed")
                  }else{
                    self.mainStateView.viewDialogMessage(title:"Error", message: "Network Error")
                   }
                  
                 self.mainStateView.viewProgress(state: false)
 
              }
              
              let bodyParameter = [
                  "uid" : PrefUtil.getUserId()
                  ] as! [String : String]
           APIRouter.makePostRequest(url: APIRouter.CHECK_STATUS_URL, bodyParameters: bodyParameter, succese: succ, failure: failureClos as (Any?) -> (), type: CheckStatusResponse.self)
          
              
              
          }

}
 
