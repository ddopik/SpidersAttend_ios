//
//  PendingVacationResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 12/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
class PendingVacationResponse: Codable {
    let status: Bool
    let data: PendingVacationData
    let code: String

    init(status: Bool, data: PendingVacationData, code: String) {
        self.status = status
        self.data = data
        self.code = code
    }
}
