//
//  UserManagementStatsData.swift
//  SpidersAttend
//
//  Created by ddopik on 1/22/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class UserManagementStatsData: Codable {
    let isManager: Bool
    let msg: String

    enum CodingKeys: String, CodingKey {
        case isManager = "is_manager"
        case msg
    }

    init(isManager: Bool, msg: String) {
        self.isManager = isManager
        self.msg = msg
    }
}
