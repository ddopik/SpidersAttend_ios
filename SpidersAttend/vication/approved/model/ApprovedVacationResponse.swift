//
//  ApprovedVacationResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 12/24/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
class ApprovedVacationResponse: Codable {
        let status: Bool
    let data: ApprovedVacationData
    let code: String

    init(status: Bool, data: ApprovedVacationData, code: String) {
        self.status = status
        self.data = data
        self.code = code
    }
}
