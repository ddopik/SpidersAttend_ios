//
//  User.swift
//  SpidersAttend
//
//  Created by ddopik on 1/1/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
@objc(User)
class User: NSObject, Codable {
    let id, name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    
}
