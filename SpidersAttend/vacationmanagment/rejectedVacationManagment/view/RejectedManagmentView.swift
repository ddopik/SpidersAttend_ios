//
//  RejectedManagmentView.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/28/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
protocol RejectedManagmentView
{
    func onRejectedManagmentVacationProgress(state:Bool)
    func viewManagmentRejectedVacations(vacationList:[Vacation])
    func viewError(msg:String)
}
