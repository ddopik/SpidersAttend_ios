//
//  PayRollDetailViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 1/13/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class PayRollDetailViewController :BaseViewController {
    
    
    private var currentPayRoll:Payroll?
    
    @IBOutlet weak var dayInMonthLabel: UILabel!
    @IBOutlet weak var dayInMonthVal: UILabel!
    
    @IBOutlet weak var workDaysLabel: UILabel!
    @IBOutlet weak var workDaysVal: UILabel!
    
    @IBOutlet weak var attendDaysLabel: UILabel!
    @IBOutlet weak var attendDaysVal: UILabel!
    
    
    @IBOutlet weak var missingDaysLabel: UILabel!
    @IBOutlet weak var missingDaysVal: UILabel!
    
    @IBOutlet weak var leaveDaysLabel: UILabel!
    @IBOutlet weak var leaveDaysVal: UILabel!
    
    
    @IBOutlet weak var nationalDaysLabel: UILabel!
    @IBOutlet weak var nationalDaysVal: UILabel!
    
    
    @IBOutlet weak var noShowDays: UILabel!
    @IBOutlet weak var noShowDaysVal: UILabel!
    
    @IBOutlet weak var remainingLeaveDaysLabel: UILabel!
    @IBOutlet weak var remainingLeaveDaysVal: UILabel!
    
    
    @IBOutlet weak var lateDaysLabel: UILabel!
    @IBOutlet weak var lateDaysVal: UILabel!
    
    @IBOutlet weak var lateHoursLabel: UILabel!
    @IBOutlet weak var lateHoursVal: UILabel!
    
    
    @IBOutlet weak var unCompleteTimeLabel: UILabel!
    @IBOutlet weak var unCompleteTimeVal: UILabel!
    
    
    @IBOutlet weak var DeductionsAmountLabel: UILabel!
    @IBOutlet weak var DeductionsAmountVal: UILabel!
    
    
    @IBOutlet weak var missingLeaveDaysLabel: UILabel!
    @IBOutlet weak var missingLeaveDaysVal: UILabel!
    
    @IBOutlet weak var totalSaleryLabel: UILabel!
    @IBOutlet weak var totalSaleryVal: UILabel!
    
    
    @IBOutlet weak var payRollYearLabel: UILabel!
    @IBOutlet weak var payRollYearVal: UILabel!
    
    
    @IBOutlet weak var payRollMonthLabel: UILabel!
    @IBOutlet weak var payRollMonthVal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInputsVal()
    }
    
    
    
    func setPayRollData(payRoll:Payroll){
        self.currentPayRoll =  payRoll
    }
    
    
    
    private func setInputsLabel(){
        
    }
    
    private func setInputsVal(){
        
        dayInMonthVal.text = currentPayRoll?.daysInMonth
        workDaysVal.text = currentPayRoll?.workdays
         attendDaysVal.text = currentPayRoll?.empTotalAttendDays
        missingDaysVal.text = currentPayRoll?.empTotalMissingDays
        
        leaveDaysVal.text = currentPayRoll?.empTotalLeaveDays
        nationalDaysVal.text = currentPayRoll?.totalNationalHolidays
        noShowDaysVal.text = currentPayRoll?.empNoshowDays
        remainingLeaveDaysVal.text = currentPayRoll?.empRemainingLeaveDays
        lateDaysVal.text = currentPayRoll?.empTotalLateDays
        lateHoursVal.text = currentPayRoll?.empTotalLateHours
        
        unCompleteTimeVal.text = currentPayRoll?.empTotalUncomplateTimes
        DeductionsAmountVal.text = currentPayRoll?.empTotalDeductionsAmount
        missingLeaveDaysVal.text =  currentPayRoll?.empTotalMissingLeaveDays
        totalSaleryVal.text = currentPayRoll?.totalSalary
        payRollYearVal.text = currentPayRoll?.payrollYear
        payRollMonthVal.text = currentPayRoll?.payrollMonth
        
    }
}
