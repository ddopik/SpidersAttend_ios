//
//  CheckStatusResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 7/2/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
struct CheckStatusResponse:Codable {
    public var code : String!
    public var data : CheckStatusResponseData!
    public var status : Bool!
    
    
    public struct CheckStatusResponseData:Codable {
        public var attendStatus : CheckStatusResponseAttendStatu!

        ///
        enum CodingKeys: String, CodingKey {
            case attendStatus = "attend_status"
      
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            if let value = try?  values.decodeIfPresent(CheckStatusResponseAttendStatu.self, forKey: .attendStatus){
                attendStatus = value
            }
            
        }
        ///
        
        
    }
    
    
    public struct CheckStatusResponseAttendStatu :Codable{
        
        public var msg : String!
        public var status : String!
        
    }


}
