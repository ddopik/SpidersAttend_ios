//
//  PendingVacationView.swift
//  SpidersAttend
//
//  Created by ddopik on 12/17/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
protocol PendingVacationView {
    func onPendingVacationProgress(state:Bool)
    func viewPendingVacations(vacationList:[Vacation])
    
    
    func onPendingVacationDeleted(vacation:Vacation,state:Bool)
    
    func viewError(msg:String)
    
    
    
}
