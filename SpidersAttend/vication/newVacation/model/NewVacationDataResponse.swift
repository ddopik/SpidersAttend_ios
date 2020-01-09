//
//  NewVacationDataResponse.swift
//  SpidersAttend
//
//  Created by ddopik on 1/1/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
class NewVacationDataResponse: Codable {
    let status: Bool
     let data: NewVacationDataResponseData
     let code: String

     init(status: Bool, data: NewVacationDataResponseData, code: String) {
         self.status = status
         self.data = data
         self.code = code
     }
}
