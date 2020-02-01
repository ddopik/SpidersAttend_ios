//
//  rejectPendingVacationResponse.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/28/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class RejectPendingVacationResponse: Codable {
    let status: Bool
    let data: RejectPendingVacationData
    let code: String

    init(status: Bool, data: RejectPendingVacationData, code: String) {
        self.status = status
        self.data = data
        self.code = code
    }
}
