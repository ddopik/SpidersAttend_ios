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
 
    @IBOutlet weak var noPendingVacationAvailaibleLabel: UILabel!
    
    @IBOutlet weak var newActionBrn: Floaty!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.items?[0].title = "Pending".localiz()
          self.tabBarController?.tabBar.items?[1].title = "Approved".localiz()
          self.tabBarController?.tabBar.items?[2].title = "Rejected".localiz()
        
        
        noPendingVacationAvailaibleLabel.text = "no Pending vacation available".localiz()
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
        
        noPendingVacationAvailaibleLabel.isHidden = true

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
        noPendingVacationAvailaibleLabel.isHidden = false
    }
    
 
    
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
