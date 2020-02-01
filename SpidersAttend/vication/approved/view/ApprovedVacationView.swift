//
//  ApprovedVacationView.swift
//  SpidersAttend
//
//  Created by ddopik on 12/24/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
protocol ApprovedVacationView {
    func onApprovedVacationProgress(state:Bool)
    func viewApprovedVacations(vacationList:[Vacation])
    func viewError(msg:String)
    
    
    
}
