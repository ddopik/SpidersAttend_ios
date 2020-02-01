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
    var vacationManagmentCellDelegate:VacationManagmentCellProtocol!
    var vacation:Vacation!
    var currentIndexPath:IndexPath!
    
    var vacatioType: VacationDataSource.VacationListType?
    
    @IBOutlet weak var vacationReason: UILabel!
    @IBOutlet weak var vacationStartDate: UILabel!
    
    @IBOutlet weak var vacationEndDate: UILabel!
    
    @IBOutlet weak var vacationDaysLeft: UILabel!
    @IBOutlet weak var vacationCreationDate: UILabel!
    //// Normal Pending Vacation  cell  --Refrences
    @IBOutlet weak var vacationDeleteBtn: UIButton!
    @IBOutlet weak var userVacationControlLockBtn: UIButton!
    ////pending   Vacation Managmetn cell  --Refrences
    @IBOutlet weak var approvePendingVacationBtn: UIButton!
    @IBOutlet weak var RejectPendingVacationBtn: UIButton!
    @IBOutlet weak var managmnetVacationControllLockBtn: UIButton!
    
    @IBAction func VacationDeleteAction(_ sender: Any) {
        vacationDelegate?.onVacationDeleteClick(vacation: self.vacation,indexPath:self.currentIndexPath)
    }
    
    
    
    @IBAction func onApproveManagmentVacationClick(_ sender: Any) {
        vacationManagmentCellDelegate?.onPendingVacationManagmentApproveClick(vacation: self.vacation, indexPath: self.currentIndexPath)
    }
    
    @IBAction func onRejectManagmentVacationClick(_ sender: Any) {
        vacationManagmentCellDelegate?.onPendingVacationManagmentRejectClick(vacation: self.vacation, indexPath: self.currentIndexPath)
    }
    
    func setPendingVacation(vacation: Vacation,currentIndexPath:IndexPath){
        
        self.vacation = vacation
        self.currentIndexPath = currentIndexPath
        vacationReason.text = vacation.reason 
        vacationStartDate.text = vacation.startDate
        vacationEndDate.text = vacation.endDate
        vacationDaysLeft.text = vacation.totalDays+" Days".localiz()
        vacationCreationDate.text = vacation.requestDate
        
        if case vacatioType = VacationDataSource.VacationListType.PENDINGMANAGMENT {
            if (vacation.requestStatus ==  MANAGMENT_PENDING_VACATION_MANAGMENT_CONTROLLER)
            {
                approvePendingVacationBtn?.isHidden = false
                RejectPendingVacationBtn?.isHidden = false
                managmnetVacationControllLockBtn.isHidden = true
            }else{
                approvePendingVacationBtn?.isHidden = true
                RejectPendingVacationBtn?.isHidden = true
                managmnetVacationControllLockBtn.isHidden = false
                
            }
        }
        
        if case vacatioType = VacationDataSource.VacationListType.PENDING {
            if (vacation.requestStatus ==  MANAGMENT_PENDING_VACATION_MANAGMENT_CONTROLLER)
            {
                vacationDeleteBtn?.isHidden = false
                userVacationControlLockBtn.isHidden = true
            }else{
                vacationDeleteBtn?.isHidden = true
                userVacationControlLockBtn.isHidden = false
            }
        }
        
    }
    
}

protocol VacationCellProtocol {
    func onVacationDeleteClick(vacation:Vacation, indexPath: IndexPath)
}


protocol VacationManagmentCellProtocol {
    
    func onPendingVacationManagmentApproveClick(vacation:Vacation, indexPath: IndexPath)
    
    func onPendingVacationManagmentRejectClick(vacation:Vacation, indexPath: IndexPath)
    
}

