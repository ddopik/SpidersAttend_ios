//
//  VacationRequestResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 1/13/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class PayrollRequestResponse: Codable {
    let status: Bool
    let data: PayrollRequestData
    let code: String

    init(status: Bool, data: PayrollRequestData, code: String) {
        self.status = status
        self.data = data
        self.code = code
    }
}
