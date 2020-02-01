//
//  PayRollViewControllerView.swift
//  SpidersAttend
//
//  Created by ddopik on 1/13/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
protocol PayRollViewControllerView {

    
    func viewPayRoll(payRollList:[Payroll])
    func viewProgress(state:Bool)
    func viewError(msg:String)
    
}
