//
//  ApprovedManagmentView.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/27/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
protocol ApprovedManagmentView {
       func onApprovedManagmentVacationProgress(state:Bool)
       func viewManagmentApprovedVacations(vacationList:[Vacation])
       func viewError(msg:String)
}
