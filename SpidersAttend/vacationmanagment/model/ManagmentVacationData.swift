//
//  ManagmentVacationData.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/28/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class ManagmentVacationData: Codable {
    let vacationData: [Vacation]
    let msg: String

    enum CodingKeys: String, CodingKey {
        case vacationData = "vacation_data"
        case msg
    }

    init(vacationData: [Vacation], msg: String) {
        self.vacationData = vacationData
        self.msg = msg
    }
}
