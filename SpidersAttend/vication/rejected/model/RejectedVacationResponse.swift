//
//  ApprovedVacationResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 12/25/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
class RejectedVacationResponse: Codable {
    let status: Bool
    let data: RejectedVacationData
    let code: String

    init(status: Bool, data: RejectedVacationData, code: String) {
        self.status = status
        self.data = data
        self.code = code
    }
}
