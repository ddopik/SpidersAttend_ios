//
//  RejectedControllerView.swift
//  SpidersAttend
//
//  Created by ddopik on 12/25/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation


protocol RejectedVacationControllerView {
    
    func onRejectedVacationProgress(state:Bool)
    func viewRejectedVacations(vacationList:[Vacation])
    func viewError(msg:String)
    
}
