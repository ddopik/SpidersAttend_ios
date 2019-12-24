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
    
    
    var vacationDelegate:VacationCellProtocol!
    var vacation:Vacation!
    var currentIndexPath:IndexPath!
    
    @IBOutlet weak var vacationReason: UILabel!
    @IBOutlet weak var vacationStartDate: UILabel!
    
    @IBOutlet weak var vacationEndDate: UILabel!
    
    @IBOutlet weak var vacationDaysLeft: UILabel!
    @IBOutlet weak var vacationCreationDate: UILabel!
    
    
    @IBAction func VacationDeleteAction(_ sender: Any) {
        vacationDelegate?.onVacationDeleteClick(vacation: self.vacation,indexPath:self.currentIndexPath)
    }
    

     
 
    
    func setPendingVacation(vacation: Vacation,currentIndexPath:IndexPath){
        
        self.vacation = vacation
        self.currentIndexPath = currentIndexPath
        vacationReason.text = vacation.reason
        vacationStartDate.text = vacation.startDate
        vacationEndDate.text = vacation.endDate
        vacationDaysLeft.text = vacation.totalDays+"Days".localiz()
        vacationCreationDate.text = vacation.requestDate
        
    }
    
}

protocol VacationCellProtocol {
    func onVacationDeleteClick(vacation:Vacation, indexPath: IndexPath)
}
