//
//  PendingVacationData.swift
//  SpidersAttend
//
//  Created by ddopik on 12/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation

struct PendingVacationData: Codable {
    let pendingVacations: [Vacation]
    let msg: String

    enum CodingKeys: String, CodingKey {
        case pendingVacations = "pending_vacations"
        case msg
    }
}
