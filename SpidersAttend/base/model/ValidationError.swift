//
//  ValidationError.swift
//  SpidersAttend
//
//  Created by ddopik on 6/22/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
struct ValidationError: Error {
    var message: String
    var errorTitle:String
    
    init(message: String,errorTitle:String) {
        self.message = message
        self.errorTitle=errorTitle
    }
}
