//
//  PendingTableView.swift
//  SpidersAttend
//
//  Created by ddopik on 12/19/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit


class PendingVacationDataSource: NSObject, UITableViewDataSource,UITableViewDelegate  {
 
    
 
    var vacationList = [Vacation]()
     
 
 
    
  
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return self.vacationList.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomVacationCell") as! CustomVacationCell
        cell.setPendingVacation(vacation: vacationList[indexPath.row])
    return cell
    }
    

//     func numberOfSections(in tableView: UITableView) -> Int {
//    return 1
//    }
//
    
//     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//    // Return false if you do not want the specified item to be editable.
//    return true
//    }
    
//    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//    vacationList.remove(at: indexPath.row)
//    tableView.deleteRows(at: [indexPath], with: .fade)
//    } else if editingStyle == .insert {
//    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//    
// 
//    
//}

}

