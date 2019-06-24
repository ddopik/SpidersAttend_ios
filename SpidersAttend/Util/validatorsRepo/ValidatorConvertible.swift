//
//  ValidatorConvertible.swift
//  SpidersAttend
//
//  Created by ddopik on 6/22/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
protocol ValidatorConvertible{
      func validate(_ value:String?) throws->String
}
