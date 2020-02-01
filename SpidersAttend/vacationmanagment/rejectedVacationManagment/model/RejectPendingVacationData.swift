//
//  rejectPendingVacationData.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/28/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class RejectPendingVacationData: Codable {
        let vacationRejected: Bool
    let msg: String

    enum CodingKeys: String, CodingKey {
        case vacationRejected = "vacation_rejected"
        case msg
    }

    init(vacationRejected: Bool, msg: String) {
        self.vacationRejected = vacationRejected
        self.msg = msg
    }
}
