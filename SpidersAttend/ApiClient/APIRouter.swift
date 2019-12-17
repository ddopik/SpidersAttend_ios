//
//  APIRouter.swift
//  SpidersAttend
//
//  Created by ddopik on 8/27/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import Alamofire

class APIRouter {
    private static var TAG :String = "APIRouter"
    
    //Network Status
    private var STATUS_OK = "200"
    private  var DEFAULT_USER_TYPE = "0"
    private  var STATUS_BAD_REQUEST = 400
    private var STATUS_401 = 401
    private var STATUS_404 = 404
    private  var STATUS_500 = 500
    private  var STATUS_ERROR = "405"
    var ERROR_STATE_1 = "login-400"
//    private static var BASE_URL :String = "https://hr-arabjet.com/"
    private static var BASE_URL :String = "https://nfc.spiderholidays.co/"

    static var LOGIN_URL = "/api/login_check"
    static var ATTEND_ACTION = "/api/attend_action"
    static var CHECK_STATUS_URL = "/api/attend_check"
    static var PENDING_VACATION_URL = "/api/Vacations/pending/"

     static var NETWORK_ATTEND_URL = "/api/network_check"
    final   var LANGUAGE_PATH_PARAMETER="lang"
    var IMAGE_BASE_URL = BASE_URL+"/en/api/uploads/thump/"

    
    
   
    
    static func makePostRequest <T : Codable>(url: String, bodyParameters: [String : String ], succese: @escaping (T?) ->(), failure: @escaping ((Any?) -> ()), type : T.Type  ) {
        
        
        let currentUrl : String = BASE_URL + PrefUtil.getAppLanguage()! + url
        
        AF.request(URL(string: currentUrl)!, method: .post, parameters: bodyParameters,encoding: URLEncoding.httpBody)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let decoder = JSONDecoder()
                        let codingData = try decoder.decode(type.self, from: response.data!)
                        succese(codingData)
                    }catch {
                        print("\(TAG) ----> Error ----> Failed Parssing Api \(currentUrl)")
                             failure ("Error")
                    }
                    
                    break
                case .failure (let error):
                    print("\(TAG) ----> Error ----> Failed Api \(currentUrl)")
                     if let httpStatusCode = response.response?.statusCode {
                        switch (httpStatusCode) {
                        case 400:
                            print("\(TAG) ----> Error 400 ----> Failed Api \(currentUrl)")
                            do {
                                let errorCodingData = try  JSONDecoder().decode(NetworkBaseError.self, from: response.data!)
                                 failure (errorCodingData)
                            }catch(let parserErrorExp){
                                print("\(TAG) ----> Error parsing Network Error of \(currentUrl) + \(parserErrorExp.localizedDescription)")
                            }
                            break
                        case 401:
                            print("\(TAG) ----> Error 401 ----> Failed Api \(currentUrl)")
                            failure(error)
                            break
                        default : do {
                            failure ("Error")
                            print("\(TAG) ----> Error unResolved Code----> Failed Api \(currentUrl)")
                            }
                        }
                    }
                    break
                }
        }
     
        
        
    }
    
    static func getPendingVacations <T : Codable>(userId:String,succese: @escaping (T?) ->(), failure: @escaping ((Any?) -> ()), type : T.Type  ) {
        
        
        
        let currentUrl : String = BASE_URL+PrefUtil.getAppLanguage()!+PENDING_VACATION_URL+"3"
        
        AF.request(URL(string: currentUrl)!, method: .get,encoding: URLEncoding.httpBody)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    do {
                        let decoder = JSONDecoder()
                        let codingData = try decoder.decode(type.self, from: response.data!)
                        succese(codingData)
                    }catch {
                        print("\(TAG) ----> Error ----> Failed Parssing Api \(currentUrl)")
                        failure("error")
                    }
                    
                    break
                case .failure (let error):
                    print("\(TAG) ----> Error ----> Failed Api \(currentUrl)")
                     if let httpStatusCode = response.response?.statusCode {
                        switch (httpStatusCode) {
                        case 400:
                            print("\(TAG) ----> Error 400 ----> Failed Api \(currentUrl)")
                            do {
                                let errorCodingData = try  JSONDecoder().decode(NetworkBaseError.self, from: response.data!)
                                 failure (errorCodingData)
                            }catch(let parserErrorExp){
                                print("\(TAG) ----> Error parsing Network Error of \(currentUrl) + \(parserErrorExp.localizedDescription)")
                            }
                            break
                        case 401:
                            print("\(TAG) ----> Error 401 ----> Failed Api \(currentUrl)")
                            failure(error)
                            break
                        default : do {
                            failure ("Error")
                            print("\(TAG) ----> Error unResolved Code----> Failed Api \(currentUrl)")
                            }
                        }
                    }
                    break
                }
        }
     
        
        
    }
}
