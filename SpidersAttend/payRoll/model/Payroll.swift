//
//  Payroll.swift
//  SpidersAttend
//
//  Created by ddopik on 1/13/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class Payroll: Codable {
    let id, uid, daysInMonth, workdays: String
    let empTotalAttendDays, empTotalMissingDays, empTotalLeaveDays, totalNationalHolidays: String
    let empNoshowDays, empRemainingLeaveDays, empTotalLateDays, empTotalLateHours: String
    let empTotalUncomplateDays, empTotalUncomplateTimes, empTotalBenefitsAmount, empTotalDeductionsAmount: String
    let empTotalMissingLeaveDays, totalSalary, payrollYear, payrollMonth: String
    let viewed, approvedStatus, approvedBy, approvedDate: String
    let addedBy, addedDate: String

    enum CodingKeys: String, CodingKey {
        case id, uid
        case daysInMonth = "days_in_month"
        case workdays
        case empTotalAttendDays = "emp_total_attend_days"
        case empTotalMissingDays = "emp_total_missing_days"
        case empTotalLeaveDays = "emp_total_leave_days"
        case totalNationalHolidays = "total_national_holidays"
        case empNoshowDays = "emp_noshow_days"
        case empRemainingLeaveDays = "emp_remaining_leave_days"
        case empTotalLateDays = "emp_total_late_days"
        case empTotalLateHours = "emp_total_late_hours"
        case empTotalUncomplateDays = "emp_total_uncomplate_days"
        case empTotalUncomplateTimes = "emp_total_uncomplate_times"
        case empTotalBenefitsAmount = "emp_total_benefits_amount"
        case empTotalDeductionsAmount = "emp_total_deductions_amount"
        case empTotalMissingLeaveDays = "emp_total_missing_leave_days"
        case totalSalary = "total_salary"
        case payrollYear = "payroll_year"
        case payrollMonth = "payroll_month"
        case viewed
        case approvedStatus = "approved_status"
        case approvedBy = "approved_by"
        case approvedDate = "approved_date"
        case addedBy = "added_by"
        case addedDate = "added_date"
    }

    init(id: String, uid: String, daysInMonth: String, workdays: String, empTotalAttendDays: String, empTotalMissingDays: String, empTotalLeaveDays: String, totalNationalHolidays: String, empNoshowDays: String, empRemainingLeaveDays: String, empTotalLateDays: String, empTotalLateHours: String, empTotalUncomplateDays: String, empTotalUncomplateTimes: String, empTotalBenefitsAmount: String, empTotalDeductionsAmount: String, empTotalMissingLeaveDays: String, totalSalary: String, payrollYear: String, payrollMonth: String, viewed: String, approvedStatus: String, approvedBy: String, approvedDate: String, addedBy: String, addedDate: String) {
        self.id = id
        self.uid = uid
        self.daysInMonth = daysInMonth
        self.workdays = workdays
        self.empTotalAttendDays = empTotalAttendDays
        self.empTotalMissingDays = empTotalMissingDays
        self.empTotalLeaveDays = empTotalLeaveDays
        self.totalNationalHolidays = totalNationalHolidays
        self.empNoshowDays = empNoshowDays
        self.empRemainingLeaveDays = empRemainingLeaveDays
        self.empTotalLateDays = empTotalLateDays
        self.empTotalLateHours = empTotalLateHours
        self.empTotalUncomplateDays = empTotalUncomplateDays
        self.empTotalUncomplateTimes = empTotalUncomplateTimes
        self.empTotalBenefitsAmount = empTotalBenefitsAmount
        self.empTotalDeductionsAmount = empTotalDeductionsAmount
        self.empTotalMissingLeaveDays = empTotalMissingLeaveDays
        self.totalSalary = totalSalary
        self.payrollYear = payrollYear
        self.payrollMonth = payrollMonth
        self.viewed = viewed
        self.approvedStatus = approvedStatus
        self.approvedBy = approvedBy
        self.approvedDate = approvedDate
        self.addedBy = addedBy
        self.addedDate = addedDate
    }
}
