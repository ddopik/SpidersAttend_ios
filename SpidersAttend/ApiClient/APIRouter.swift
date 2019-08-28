//
//  APIRouter.swift
//  SpidersAttend
//
//  Created by ddopik on 8/27/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class APIRouter {
    
    //Network Status
    private var STATUS_OK = "200"
    private  var DEFAULT_USER_TYPE = "0"
    private  var STATUS_BAD_REQUEST = 400
    private var STATUS_401 = 401
    private var STATUS_404 = 404
    private  var STATUS_500 = 500
    private  var STATUS_ERROR = "405"
      var ERROR_STATE_1 = "login-400"
       var IMAGE_BASE_URL = "https://hr-arabjet.com/en/api/uploads/thump/"
    
    private   var BASE_URL :String = "https://hr-arabjet.com/{lang}/api"
    private   var LOGIN_URL = "$BASE_URL/login_check"
        var ATTEND_ACTION_URL = "$BASE_URL/attend_action"
        var ATTEND_CHECK_URL = "$BASE_URL/attend_check"
        var LANGUAGE_PATH_PARAMETER="lang"
    
    
    
    
    
  static func makePostRequest (url: String, bodyParameters: [String : String ], succese: (Any?) ->(), failure: ((Any?) -> (), type : T.Type) ) {
        
        AF.request(url, method: .post, parameters: bodyParameters , encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch response.result
            {
            case .success(let json):
                let jsonData = json as! Any
                print(jsonData)
                
            case .failure(let error):
                self.errorFailer(error: error)
            }
        }
        
    }
    
    
    
    
    
}
