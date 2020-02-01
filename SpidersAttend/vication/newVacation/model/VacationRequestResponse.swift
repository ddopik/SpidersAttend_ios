//
//  VacationRequestResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 1/12/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation


class VacationRequestResponse: Codable {
    let status: Bool
    let data: VacationRequestData
    let code: String

    init(status: Bool, data: VacationRequestData, code: String) {
        self.status = status
        self.data = data
        self.code = code
    }
}
