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
    var vacationListType:VacationListType!
    
    init(vacationType:VacationListType) {
        self.vacationListType = vacationType
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vacationList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vacationCell = tableView.dequeueReusableCell(withIdentifier: "CustomVacationCell") as! CustomVacationCell
        vacationCell.setPendingVacation(vacation: vacationList[indexPath.row],currentIndexPath : indexPath)
        vacationCell.vacationDelegate = self.vacationCellDelegate
      
        
        return vacationCell
    }
    enum VacationListType {
        case PENDING
        case REJECTED
        case APPROVED
    }
    
     
    
}

