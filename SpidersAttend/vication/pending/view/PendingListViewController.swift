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
    var pendingVacationDataSource: VacationDataSource!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pendingVacationPresenter = PendingVacationPresenterImpl(pendingVacationView: self)
        pendingVacationDataSource =  VacationDataSource()
        
        self.pendingVacationDataSource.vacationCellDelegate = self
        self.pendingVacationTableView.dataSource = pendingVacationDataSource
        self.pendingVacationTableView.delegate = (pendingVacationDataSource!)
        self.pendingVacationTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pendingVacationPresenter.getPendingVacations()
    }
    func viewPendingVacations(vacationList: [Vacation]) {
        pendingVacationDataSource.vacationList.removeAll()
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
    
    func onPendingVacationDeleted(vacation: Vacation,indexPath:IndexPath, state: Bool) {
        if(state){
        pendingVacationDataSource.vacationList.remove(at: indexPath.row)
           pendingVacationTableView.beginUpdates()
           pendingVacationTableView.deleteRows(at: [indexPath], with: .automatic)
           pendingVacationTableView.endUpdates()
        }else{
//            showAlert(withTitle: "error".localiz(), message: "error_deleting_vacation")
        }
    }
    
    
    func viewError(msg: String) {
        
    }
    
    
    
    
}
extension PendingListViewController:VacationCellProtocol{
    func onVacationDeleteClick(vacation: Vacation, indexPath: IndexPath) {
        pendingVacationPresenter.deletePendingVacation(vacation: vacation, indexPath: indexPath)
    }
}

