//
//  PendingViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 12/15/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit
import Floaty
class PendingListViewController: BaseViewController,PendingVacationView {
    
    @IBOutlet weak var pendingVacationTableView: UITableView!
    var pendingVacationPresenter :PendingVacationPresenter!
    var pendingVacationDataSource: VacationDataSource!
    
    
    @IBOutlet weak var newActionBrn: Floaty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pendingVacationPresenter = PendingVacationPresenterImpl(pendingVacationView: self)
        pendingVacationDataSource =  VacationDataSource(vacationType: VacationDataSource.VacationListType.PENDING)
        
        self.pendingVacationDataSource.vacationCellDelegate = self
        self.pendingVacationTableView.dataSource = pendingVacationDataSource
        self.pendingVacationTableView.delegate = (pendingVacationDataSource!)
        self.pendingVacationTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.pendingVacationPresenter.getPendingVacations()
        
        newActionBrn.fabDelegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    // Event handling method
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
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
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //
    //
    //        if segue.identifier == "NEW_VACATION"{
    //            performSegue(withIdentifier: "NEW_VACATION", sender: nil)
    //         }
    //    }
    
    
}
extension PendingListViewController:VacationCellProtocol{
    func onVacationDeleteClick(vacation: Vacation, indexPath: IndexPath) {
        pendingVacationPresenter.deletePendingVacation(vacation: vacation, indexPath: indexPath)
    }
}

extension PendingListViewController: FloatyDelegate {
    func emptyFloatySelected(_ floaty: Floaty) {
        self.tabBarController?.tabBar.isHidden = true
        self.performSegue(withIdentifier: "new_vacation", sender: nil)
    }
}
