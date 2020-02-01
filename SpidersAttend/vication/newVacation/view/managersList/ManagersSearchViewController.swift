//
//  SearchManagerListViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 1/6/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class ManagersSearchViewController :BaseViewController{
    var managersList: [User] = []
    var managerDataSource:ManagersDataSource!
    var searchMangerListDelegate:ManagersSearchDelegate?
    let searchController = UISearchController(searchResultsController: nil)
 
    @IBOutlet weak var managerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        managerDataSource = ManagersDataSource()
        managerTableView.dataSource = managerDataSource
        managerTableView.delegate = managerDataSource
        managerDataSource.managerDataSourceDelegate = self
        
        if (!managersList.isEmpty){
            viewManagersList(managerList: managersList)
        }
        
        
        
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Manageres".localiz()
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = true

        searchController.hidesNavigationBarDuringPresentation = true
    }
    var isSearchBarEmpty: Bool {
        return  searchController.searchBar.text?.isEmpty ?? true
    }
    func filterContentForSearchText(_ searchText: String) {
        
        
        
        
        managerDataSource.setFilteredManagersList(managersList: managersList.filter { (user: User) -> Bool in
            return user.name.lowercased().contains(searchText.lowercased())  })
        managerTableView.reloadData()
    }
    
    
    public func setManagersList(managerList:[User]){
        self.managersList = managerList
    }
}
extension ManagersSearchViewController: UISearchResultsUpdating {
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        
    }
}



extension ManagersSearchViewController {
    
    func viewProgress(state: Bool) {
                if(state){
                    super.progressView.isHidden = false
                }else{
                    super.progressView.isHidden = true
        
                }
    }
    func viewManagersList(managerList: [User]) {
        managerDataSource.setManagersList(managersList : managerList)
        managerTableView.reloadData()
    }
    
}

extension ManagersSearchViewController: ManagerDataSourceDelegate{
    
    
    func onManagerSelected(user: User) {
        _ = navigationController?.popViewController(animated: true)
        searchMangerListDelegate?.onManagerSelected(user:user)
    }
    
    func isFiltering() -> Bool {
        return  searchController.isActive && !isSearchBarEmpty
    }
    
}
protocol ManagersSearchDelegate {
    func onManagerSelected(user:User)
}
