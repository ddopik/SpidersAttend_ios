//
//  NewVacationControllerPresenter.swift
//  SpidersAttend
//
//  Created by ddopik on 1/2/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
protocol  NewVacationControllerPresenter {
    func  getVacationData()
    func sendNewVacationRequest(newVacationObj:NewVacationObj)
}
