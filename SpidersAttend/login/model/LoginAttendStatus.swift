//
//  LoginAttendStatu.swift
//  SpidersAttend
//
//  Created by ddopik on 8/27/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
struct LoginAttendStatus : Codable {
    let status : String?
    let msg : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case msg = "msg"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }
    
}
