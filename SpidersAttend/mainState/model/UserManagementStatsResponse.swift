//
//  CheckUserManagementStatsResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 1/22/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class UserManagementStatsResponse: Codable {
    let status: Bool
    let data: UserManagementStatsData
    let code: String

    init(status: Bool, data: UserManagementStatsData, code: String) {
        self.status = status
        self.data = data
        self.code = code
    }
}
