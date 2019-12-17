//
//  CustomVacationCell.swift
//  SpidersAttend
//
//  Created by ddopik on 12/15/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit
 
@IBDesignable class CustomVacationCell:UITableViewCell {
    @IBOutlet weak var vacationReason: UILabel!
    @IBOutlet weak var vacationStartDate: UILabel!
    
    @IBOutlet weak var vacationEndDate: UILabel!
    
    @IBOutlet weak var vacationDaysLeft: UILabel!
    @IBOutlet weak var vacationCreationDate: UILabel!
    
    
    @IBAction func VacationDeleteAction(_ sender: Any) {
    }
    

     
 
    
    func setPendingVacation(vacation: Vacation){
        vacationReason.text = vacation.reason
        vacationStartDate.text = vacation.startDate
        vacationEndDate.text = vacation.endDate
        vacationDaysLeft.text = vacation.totalDays+"Days".localiz()
        vacationCreationDate.text = vacation.requestDate
    }
    
    
}
