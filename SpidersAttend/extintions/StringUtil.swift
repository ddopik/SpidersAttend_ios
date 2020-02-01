//
//  StringUtil.swift
//  SpidersAttend
//
//  Created by ddopik on 1/16/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
extension String {
    func prepending(prefix: String) -> String {
        return prefix + self
    }
   func apendingTo(sufix: String) -> String {
          return self + sufix
      }
}
