//
//  LoginData.swift
//  SpidersAttend
//
//  Created by ddopik on 8/27/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
struct LoginData : Codable {
    let user_data : LoginUserData?
    let attend_status : LoginAttendStatus?
    
    enum CodingKeys: String, CodingKey {
        
        case user_data = "user_data"
        case attend_status = "attend_status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user_data = try values.decodeIfPresent(LoginUserData.self, forKey: .user_data)
        attend_status = try values.decodeIfPresent(LoginAttendStatus.self, forKey: .attend_status)
    }
    
}
