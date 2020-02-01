//
//  ManagmentVacationApproveData.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/28/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class ManagmentVacationApproveData :Codable {
    let vacationApproved: Bool
    let msg: String

    enum CodingKeys: String, CodingKey {
        case vacationApproved = "vacation_approved"
        case msg
    }

    init(vacationApproved: Bool, msg: String) {
        self.vacationApproved = vacationApproved
        self.msg = msg
    }
}
