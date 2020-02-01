//
//  PendingVacationPresenter.swift
//  SpidersAttend
//
//  Created by ddopik on 12/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
protocol PendingVacationPresenter {
    func getPendingVacations()
    func deletePendingVacation(vacation: Vacation, indexPath: IndexPath)
}
