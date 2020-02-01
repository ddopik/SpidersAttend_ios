//
//  PendingManagmentVacationPresenter.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/27/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
protocol PendingManagmentVacationPresenter {
        func getPendingManagmentVacations()
    func approvePendingVacation(vacation: Vacation)
    func rejectPendingVacation(vacation: Vacation, vacationReason: String)

}

