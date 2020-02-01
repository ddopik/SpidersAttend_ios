//
//  PendingTableView.swift
//  SpidersAttend
//
//  Created by ddopik on 12/19/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit


class VacationDataSource: NSObject, UITableViewDataSource,UITableViewDelegate  {
    
    
    
    var vacationList = [Vacation]()
    var vacationCellDelegate:VacationCellProtocol!
    var vacationManagmentCellDelegate :VacationManagmentCellProtocol!
    var vacationListType:VacationListType!
    
    init(vacationType:VacationListType) {
        self.vacationListType = vacationType
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vacationList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vacationCell = tableView.dequeueReusableCell(withIdentifier: "CustomVacationCell") as! CustomVacationCell
        vacationCell.vacatioType = vacationListType
        vacationCell.setPendingVacation(vacation: vacationList[indexPath.row], currentIndexPath : indexPath)
        
        switch self.vacationListType {
        case .PENDING :
            vacationCell.vacationDelegate = self.vacationCellDelegate
        case .PENDINGMANAGMENT :
            do {
            vacationCell.vacationManagmentCellDelegate = self.vacationManagmentCellDelegate
             
        }
        default:
            vacationCellDelegate = nil
            vacationManagmentCellDelegate = nil
            
        }
        return vacationCell
    }
    
    
    func removeVacation(vacation:Vacation ,tableView:UITableView){
        
        
        
                for index  in 0..<vacationList.count {
                    if(vacationList[index].id ==  vacation.id)
                    {
                        vacationList.remove(at: index)
                        break
                    }
                }
         let indexPathArr = tableView.indexPathsForVisibleRows
        for indexRow in indexPathArr! {
            let cell = tableView.cellForRow(at: indexRow) as! CustomVacationCell
            if(cell.vacation.id ==  vacation.id)
            {
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexRow], with: .automatic)
                tableView.endUpdates()
                break
            }
        }
        
        

        
        
    }
    enum VacationListType {
        case PENDING
        case REJECTED
        case APPROVED
        case PENDINGMANAGMENT
    }
    
    
    
}

