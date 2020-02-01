//
//  Vacation.swift
//  SpidersAttend
//
//  Created by ddopik on 12/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
struct Vacation: Codable {
let id, uid, reason, startDate: String
let endDate, totalDays, vacationsTypeID, requestTo: String
let requestStatus, adminApprovedBy, adminRejectedBy, approvedBy: String
let rejectedBy, rejectReason, approveRejectDate, requestDate: String

enum CodingKeys: String, CodingKey {
    case id, uid, reason
    case startDate = "start_date"
    case endDate = "end_date"
    case totalDays = "total_days"
    case vacationsTypeID = "vacations_type_id"
    case requestTo = "request_to"
    case requestStatus = "request_status"
    case adminApprovedBy = "admin_approved_by"
    case adminRejectedBy = "admin_rejected_by"
    case approvedBy = "approved_by"
    case rejectedBy = "rejected_by"
    case rejectReason = "reject_reason"
    case approveRejectDate = "approve_reject_date"
    case requestDate = "request_date"
}
}
