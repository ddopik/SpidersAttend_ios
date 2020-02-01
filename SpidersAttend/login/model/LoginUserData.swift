//
//  LoginUserData.swift
//  SpidersAttend
//
//  Created by ddopik on 8/27/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//
import Foundation
struct LoginUserData : Codable {
    let name : String?
    let email : String?
    let img : String?
    let gender : String?
    let track : String?
    let uid : String?
    let lat : String?
    let lng : String?
    let radius : String?
    let token : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case email = "email"
        case img = "img"
        case gender = "gender"
        case track = "track"
        case uid = "uid"
        case lat = "lat"
        case lng = "Lng"
        case radius = "radius"
        case token = "token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        img = try values.decodeIfPresent(String.self, forKey: .img)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        track = try values.decodeIfPresent(String.self, forKey: .track)
        uid = try values.decodeIfPresent(String.self, forKey: .uid)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
        radius = try values.decodeIfPresent(String.self, forKey: .radius)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }
    
}
