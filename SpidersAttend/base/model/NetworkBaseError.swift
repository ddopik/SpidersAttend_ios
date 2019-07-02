//
//  NetworkBaseError.swift
//  SpidersAttend
//
//  Created by ddopik on 6/24/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
struct NetworkBaseError : Codable {
    
    let code : String?
    let data : NetworkBaseErrorData?
    let status : Bool?
 
    // need to add helper constructor to unable user to intialize NetworkBaseError manually
    
    enum CodingKeys: String, CodingKey {
        case code = "code"
        case data = "data"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        data = try values.decodeIfPresent(NetworkBaseErrorData.self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
 
    }
    
    
struct NetworkBaseErrorData : Codable {
    
    var msg : String?
    
    enum CodingKeys: String, CodingKey {
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
    
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)      
    }
    
    
    }
}
