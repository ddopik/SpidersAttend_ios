//
//  PendingManagmentView.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/27/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
protocol PendingManagmentView {
    
    
    func onPendingManagmentVacationProgress(state:Bool)
    
    func viewManagmentPendingVacations(vacationList:[Vacation])
    
    func onPendingManagmentVacationApproved(vacation:Vacation,state:Bool)

    func onPendingManagmentVacationRejected(vacation:Vacation,state:Bool)
    
    func viewError(msg:String)
    
}
