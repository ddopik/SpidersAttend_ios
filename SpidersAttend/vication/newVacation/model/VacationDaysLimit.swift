//
//  VacationDaysLimit.swift
//  SpidersAttend
//
//  Created by ddopik on 1/1/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class VacationDaysLimit : Codable {
    let vacationDaysLimit: String

     enum CodingKeys: String, CodingKey {
         case vacationDaysLimit = "vacation_days_limit"
     }

     init(vacationDaysLimit: String) {
         self.vacationDaysLimit = vacationDaysLimit
     }
}
