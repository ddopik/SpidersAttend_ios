//
//  NewVacationDataResponseData.swift
//  SpidersAttend
//
//  Created by ddopik on 1/1/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class NewVacationDataResponseData: Codable {
    let users: [User]
    let vacationsType :[VacationType]
    let vacationDaysLimit: [VacationDaysLimit]
    let msg: String

    enum CodingKeys: String, CodingKey {
        case users
        case vacationsType = "vacations_type"
        case vacationDaysLimit = "vacation_days_limit"
        case msg
    }

    init(users: [User], vacationsType: [VacationType], vacationDaysLimit: [VacationDaysLimit], msg: String) {
        self.users = users
        self.vacationsType = vacationsType
        self.vacationDaysLimit = vacationDaysLimit
        self.msg = msg
    }
}
