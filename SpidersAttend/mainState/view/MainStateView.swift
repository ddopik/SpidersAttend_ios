//
//  MainStateView.swift
//  SpidersAttend
//
//  Created by ddopik on 12/1/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
protocol MainStateView {
    func updateView(newDate: Date)
     func viewUserStatsMessage(userStatsMessage:String)
     func viewProgress(state:Bool)
    func  showMessage(withTitle title: String?, message: String?)
    func viewDialogMessage(title:String,message:String)
    func setManagmentControll(state:Bool)
}
