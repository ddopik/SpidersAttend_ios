//
//  ManagersDataSource.swift
//  SpidersAttend
//
//  Created by ddopik on 1/1/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class ManagersDataSource : NSObject, UITableViewDataSource,UITableViewDelegate{
    
    var managerDataSourceDelegate:ManagerDataSourceDelegate?
    private var managersList = [User]()
    var filteredManagers: [User] = []
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let managerCell = tableView.dequeueReusableCell(withIdentifier: "ManagerCellView", for: indexPath) as! ManagerCellView
        
        if  managerDataSourceDelegate?.isFiltering() ?? false{
            managerCell.managerName.text = filteredManagers[indexPath.row].name
            
        }else{
            managerCell.managerName.text = managersList[indexPath.row].name
            
        }
        
        return managerCell
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        if  managerDataSourceDelegate?.isFiltering() ?? false{
            return filteredManagers.count
        }
        
        return managersList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        managerDataSourceDelegate?.onManagerSelected(user: managersList[indexPath.row])
        
    }
    public func setManagersList(managersList:[User]){
        self.managersList.removeAll()
        self.managersList.insert(contentsOf: managersList, at: 0)
    }
    
    
    
    public func setFilteredManagersList(managersList:[User]){
        self.filteredManagers.removeAll()
        self.filteredManagers.insert(contentsOf: managersList, at: 0)
    }
}




protocol ManagerDataSourceDelegate {
    func onManagerSelected(user:User)
    func isFiltering() ->Bool
}

