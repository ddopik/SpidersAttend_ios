//
//  ManagerListViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 1/1/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class VacationTypesSearchViewController :BaseViewController   {
    
    var vacationsTypesList: [VacationType] = []
    var vacationsTypesDataSource:VacationsTypesDataSource!
    var vacationTypesDelegate:VacationTypesDelegate?
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var vacationTypeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        vacationsTypesDataSource = VacationsTypesDataSource()
        vacationTypeTableView.dataSource = vacationsTypesDataSource
        vacationTypeTableView.delegate = vacationsTypesDataSource
        vacationsTypesDataSource.vacationDataSourceDelegate = self
        
        if (!vacationsTypesList.isEmpty){
            viewVacationTypesList(vacationTypeList: vacationsTypesList)
        }
        
        
        
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Vacation Type".localiz()
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.hidesNavigationBarDuringPresentation = true
    }
    var isSearchBarEmpty: Bool {
        return  searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    
    
    func filterContentForSearchText(_ searchText: String) {
        
        vacationsTypesDataSource.setFilteredVacationsTypesList(vacationList: vacationsTypesList.filter {
            (vacationType: VacationType) -> Bool in
            return vacationType.name.lowercased().contains(searchText.lowercased())  })
        vacationTypeTableView.reloadData()
    }
    
    
    public func setVacationTypesList(vacationTypeList:[VacationType]){
        self.vacationsTypesList = vacationTypeList
    }
}
extension VacationTypesSearchViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
}



extension VacationTypesSearchViewController {
    
    func viewProgress(state: Bool) {
        if(state){
            super.progressView.isHidden = false
        }else{
            super.progressView.isHidden = true
            
        }
    }
    func viewVacationTypesList(vacationTypeList: [VacationType]) {
        vacationsTypesDataSource.setVacationsTypesList(vacationList: vacationTypeList)
        vacationTypeTableView.reloadData()
    }
    
}

extension VacationTypesSearchViewController: VacationDataSourceDelegate{
    func onVacationSelected(vacationType: VacationType) {
        _ = navigationController?.popViewController(animated: true)
        vacationTypesDelegate?.onVacationSelected(vacation:vacationType)
    }
    
    
    

    func isFiltering() -> Bool {
        return  searchController.isActive && !isSearchBarEmpty
    }
    
}




protocol VacationTypesDelegate {
    func onVacationSelected(vacation:VacationType)
}

