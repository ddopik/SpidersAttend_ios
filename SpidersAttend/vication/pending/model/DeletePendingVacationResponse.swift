//
//  DeletePendingVacationResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 12/24/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
class DeletePendingVacationResponse: Codable {
    let status: Bool
    let data: DeleteVacationData
    let code: String

    init(status: Bool, data: DeleteVacationData, code: String) {
        self.status = status
        self.data = data
        self.code = code
    }
}
