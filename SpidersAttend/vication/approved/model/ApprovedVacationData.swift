//
//  ApprovedVacationData.swift
//  SpidersAttend
//
//  Created by ddopik on 12/24/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
class ApprovedVacationData:Codable{
    let approvedVacations: [Vacation]
    let msg: String

    enum CodingKeys: String, CodingKey {
        case approvedVacations = "approved_vacations"
        case msg
    }
}
