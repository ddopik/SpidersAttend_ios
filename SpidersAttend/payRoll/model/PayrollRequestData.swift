//
//  PayrollRequestData.swift
//  SpidersAttend
//
//  Created by ddopik on 1/13/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class PayrollRequestData: Codable {
    let payroll: [Payroll]
    let msg: String

    init(payroll: [Payroll], msg: String) {
        self.payroll = payroll
        self.msg = msg
    }
}
