//
//  PayRollDataSource.swift
//  SpidersAttend
//
//  Created by ddopik on 1/13/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class PayRollDataSource:NSObject,UITableViewDataSource,UITableViewDelegate{
    
    private var payRollList :[Payroll] = [Payroll]()
     var payRollDataSourceDelegate:PayRollDataSourceDelegate!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return payRollList.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let payRollCell = tableView.dequeueReusableCell(withIdentifier: "PayRollCellView", for: indexPath) as! PayRollCellView
        
        payRollCell.payRollTotalSalery.text = payRollList[indexPath.row].totalSalary
        payRollCell.payRollYear.text = payRollList[indexPath.row].payrollYear
        payRollCell.payRollMonth.text = payRollList[indexPath.row].payrollMonth
        
        
        return payRollCell
    }
    
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        payRollDataSourceDelegate?.onPayRollClick(payRoll: payRollList[indexPath.row])
    }
    func setPayRollList(payRollList:[Payroll]){
        self.payRollList.removeAll()
        self.payRollList.insert(contentsOf: payRollList, at: 0)
        
    }
    
    
 
    
}
 protocol PayRollDataSourceDelegate {
   func onPayRollClick(payRoll:Payroll)
 }
