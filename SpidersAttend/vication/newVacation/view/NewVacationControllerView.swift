//
//  NewVacationControllerView.swift
//  SpidersAttend
//
//  Created by ddopik on 1/2/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
protocol NewVacationControllerView{
    
    func viewProgress(state:Bool)
    
    func setVacationTypes(vacationTypes: [VacationType])
    func setManagersList(managersList:[User])
    func onVacationCreated(state:Bool)
    func viewError(title:String,body:String)
}
