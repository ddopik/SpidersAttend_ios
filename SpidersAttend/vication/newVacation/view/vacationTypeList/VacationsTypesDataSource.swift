//
//  VacationsTypesDataSource.swift
//  SpidersAttend
//
//  Created by ddopik on 1/8/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class VacationsTypesDataSource  : NSObject, UITableViewDataSource,UITableViewDelegate{
         var vacationDataSourceDelegate:VacationDataSourceDelegate?
        private var vacationList = [VacationType]()
        var filteredVacations: [VacationType] = []
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let vacationTypeCell = tableView.dequeueReusableCell(withIdentifier: "VacationTypeCellView", for: indexPath) as! VacationTypeCellView
            
            if  vacationDataSourceDelegate?.isFiltering() ?? false{
                vacationTypeCell.vacationName.text = filteredVacations[indexPath.row].name
                
            }else{
                vacationTypeCell.vacationName.text = vacationList[indexPath.row].name
                
            }
            
            return vacationTypeCell
        }
        
        func tableView(_ tableView: UITableView,
                       numberOfRowsInSection section: Int) -> Int {
            
            if  vacationDataSourceDelegate?.isFiltering() ?? false{
                return filteredVacations.count
            }
            
            return vacationList.count
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            vacationDataSourceDelegate?.onVacationSelected(vacationType: vacationList[indexPath.row])
            
        }
        public func setVacationsTypesList(vacationList:[VacationType]){
            self.vacationList.removeAll()
            self.vacationList.insert(contentsOf: vacationList, at: 0)
            
        }
        
        
        
        public func setFilteredVacationsTypesList(vacationList:[VacationType]){
            self.filteredVacations.removeAll()
            self.filteredVacations.insert(contentsOf: vacationList, at: 0)
        }
    }


protocol VacationDataSourceDelegate {
    func onVacationSelected(vacationType:VacationType)
    func isFiltering() ->Bool
}

