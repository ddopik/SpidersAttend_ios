//
//  AttendPresenter.swift
//  SpidersAttend
//
//  Created by ddopik on 12/1/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation

protocol AttendPresenter {
    func requestUserStatus()
    func sendAttendAction(attendType:NavigationType)
  }
