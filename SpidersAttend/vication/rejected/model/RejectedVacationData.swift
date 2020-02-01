//
//  RejectedVacationData.swift
//  SpidersAttend
//
//  Created by ddopik on 12/25/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
class RejectedVacationData: Codable {
    let rejectedVacations: [Vacation]
    let msg: String

    enum CodingKeys: String, CodingKey {
        case rejectedVacations = "rejected_vacations"
        case msg
    }
}
