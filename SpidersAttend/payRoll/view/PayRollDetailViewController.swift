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
    
    @IBOutlet weak var benifitsAmountLabel: UILabel!
    @IBOutlet weak var benifitsAmountVal: UILabel!
    
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
        setInputsLabel()
    }
    
    
    
    func setPayRollData(payRoll:Payroll){
        self.currentPayRoll =  payRoll
    }
    
    
    
    private func setInputsLabel(){
        dayInMonthLabel.text = "Day in month".localiz().apendingTo(sufix:" : ")
        
        workDaysLabel.text = "work days".localiz().apendingTo(sufix:" : ")
    
        attendDaysLabel.text = "Total Attend days".localiz().apendingTo(sufix:" : ")
        
        
        missingDaysLabel.text = "Total missing days".localiz().apendingTo(sufix:" : ")
        
        leaveDaysLabel.text = "Total leave days".localiz().apendingTo(sufix:" : ")
        
        
        nationalDaysLabel.text = "Total national days".localiz().apendingTo(sufix:" : ")
        
        
        noShowDays.text = "Total no show days".localiz().apendingTo(sufix:" : ")
        
        remainingLeaveDaysLabel.text = "Remaining leave days".localiz().apendingTo(sufix:" : ")
        
        
        lateDaysLabel.text = "Total late days".localiz().apendingTo(sufix:" : ")
        
        lateHoursLabel.text = "Total late hours".localiz().apendingTo(sufix:" : ")
        
        
        benifitsAmountLabel.text = "Benefits ammount".localiz().apendingTo(sufix:" : ")
        
        unCompleteTimeLabel.text = "Un completed times".localiz().apendingTo(sufix:" : ")
        
        
        DeductionsAmountLabel.text = "Deductions amount".localiz().apendingTo(sufix:" : ")
        
        
        missingLeaveDaysLabel.text = "Missing leave days".localiz().apendingTo(sufix:" : ")
        
        totalSaleryLabel.text = "Total salary".localiz().apendingTo(sufix:" : ")
        
        
        payRollYearLabel.text = "PayRoll year".localiz().apendingTo(sufix:" : ")
        
        
        payRollMonthLabel.text = "PayRoll month".localiz().apendingTo(sufix:" : ")
    }
    
    private func setInputsVal(){
        print("------->  \( currentPayRoll?.workdays) ----->   \( currentPayRoll?.id)" )
        
        
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
        
        benifitsAmountVal.text = currentPayRoll?.empTotalBenefitsAmount
        DeductionsAmountVal.text = currentPayRoll?.empTotalDeductionsAmount
        missingLeaveDaysVal.text =  currentPayRoll?.empTotalMissingLeaveDays
        totalSaleryVal.text = currentPayRoll?.totalSalary.trimmingCharacters(in: .whitespaces)
        payRollYearVal.text = currentPayRoll?.payrollYear
        payRollMonthVal.text = currentPayRoll?.payrollMonth
        
    }
}
