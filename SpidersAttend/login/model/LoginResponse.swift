//
//  LoginResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 8/27/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
struct LoginResponse : Codable {
    let status : Bool?
    let data : LoginData?
    let code : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
        case code = "code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
        code = try values.decodeIfPresent(String.self, forKey: .code)
    }
    
}
