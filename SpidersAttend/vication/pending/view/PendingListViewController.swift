//
//  PendingViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 12/15/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class PendingListViewController: BaseViewController,PendingVacationView {
    
    @IBOutlet weak var pendingVacationTableView: UITableView!
    
    var pendingVacationPresenter :PendingVacationPresenter!
    
    var vacationList = [Vacation]()
    
    var pendingVacationDataSource: PendingVacationDataSource!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pendingVacationPresenter = PendingVacationPresenterImpl(pendingVacationView: self)
        pendingVacationDataSource =  PendingVacationDataSource()
        
        self.pendingVacationTableView.dataSource = pendingVacationDataSource
        self.pendingVacationTableView.delegate = (pendingVacationDataSource as! UITableViewDelegate)
        self.pendingVacationPresenter.getPendingVacations()
    }
    
    func viewPendingVacations(vacationList: [Vacation]) {
                    pendingVacationDataSource.vacationList.insert(contentsOf: vacationList, at: 0)
 
         self.pendingVacationTableView.reloadData()
        
    }
    
    
    func onPendingVacationProgress(state: Bool) {
        if (state){
            super.startProgress()
        }else{
            super.stopProgress()
        }
    }
    
    func onPendingVacationDeleted(vacation: Vacation, state: Bool) {
        
    }
    
    
    func viewError(msg: String) {
        
    }
    
    
    
}
//extension PendingListViewController: UITableViewDataSource,UITableViewDelegate{
//
//
//        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            return self.vacationList.count
//        }
//
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomVacationCell") as! CustomVacationCell
//            cell.setPendingVacation(vacation: vacationList[indexPath.row])
//            return cell
//        }
//
//
//    }


