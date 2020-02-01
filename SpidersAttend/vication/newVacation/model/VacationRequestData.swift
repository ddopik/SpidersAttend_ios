//
//  VacationRequestData.swift
//  SpidersAttend
//
//  Created by ddopik on 1/12/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class VacationRequestData: Codable {
    let uid, reason, startDate, endDate: String
    let totalDays: Int
    let vacationsTypeID, requestTo, requestStatus, requestDate: String
    let msg: String

    enum CodingKeys: String, CodingKey {
        case uid, reason
        case startDate = "start_date"
        case endDate = "end_date"
        case totalDays = "total_days"
        case vacationsTypeID = "vacations_type_id"
        case requestTo = "request_to"
        case requestStatus = "request_status"
        case requestDate = "request_date"
        case msg
    }

    init(uid: String, reason: String, startDate: String, endDate: String, totalDays: Int, vacationsTypeID: String, requestTo: String, requestStatus: String, requestDate: String, msg: String) {
        self.uid = uid
        self.reason = reason
        self.startDate = startDate
        self.endDate = endDate
        self.totalDays = totalDays
        self.vacationsTypeID = vacationsTypeID
        self.requestTo = requestTo
        self.requestStatus = requestStatus
        self.requestDate = requestDate
        self.msg = msg
    }
}
