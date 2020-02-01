//
//  AttendView.swift
//  SpidersAttend
//
//  Created by ddopik on 12/1/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import CoreLocation
protocol AttendView  {
    func setAttendBtnState(state :Bool)
    func setAttendMessageStates(statsID:String)
    func viewProgress(state:Bool)
    func viewDialogMessage(title:String,message:String)
    func viewAlertMessage(title:String,message:String)
     func navigate(dest:NavigationType,curenrtlocation: CLLocation)

}
