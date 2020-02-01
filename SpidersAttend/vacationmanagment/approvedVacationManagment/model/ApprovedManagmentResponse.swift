//
//  ApprovedManagmentResponse.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/28/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class ApprovedManagmentResponse{
    let status: Bool
    let data: ApprovedManagmentVacationData
    let code: String

    init(status: Bool, data: ApprovedManagmentVacationData, code: String) {
        self.status = status
        self.data = data
        self.code = code
    }
}
