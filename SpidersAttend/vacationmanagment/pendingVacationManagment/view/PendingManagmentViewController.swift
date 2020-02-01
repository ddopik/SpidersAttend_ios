//
//  PendingManagmentViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 1/16/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class PendingManagmentViewController :BaseViewController,PendingManagmentView{
    
    
    
    
    @IBOutlet weak var pendingManagmentVacationTableView: UITableView!
    @IBOutlet weak var noPendingVacationManagmentLabel: UILabel!
    var pendingManagmentVacationDataSource: VacationDataSource!
    //    var rejectVacationAlertController : RejectVacationAlertController!
    
    var pendingManagmentVacationPresenter :PendingManagmentVacationPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.items?[0].title = "Pending".localiz()
        self.tabBarController?.tabBar.items?[1].title = "Approved".localiz()
        self.tabBarController?.tabBar.items?[2].title = "Rejected".localiz()
        
        //        rejectVacationAlertController = RejectVacationAlertController.getInstance(parentView: self.view)
        
        noPendingVacationManagmentLabel?.text = "No Managment Pending vacation available".localiz()
        pendingManagmentVacationPresenter = PendingManagmentVacationPresenterImpl(pendingManagmentView: self)
        pendingManagmentVacationDataSource =  VacationDataSource(vacationType: VacationDataSource.VacationListType.PENDINGMANAGMENT)
         self.pendingManagmentVacationDataSource.vacationManagmentCellDelegate = self
        self.pendingManagmentVacationTableView.dataSource = pendingManagmentVacationDataSource
        self.pendingManagmentVacationTableView.delegate = (pendingManagmentVacationDataSource!)
        self.pendingManagmentVacationTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.pendingManagmentVacationPresenter.getPendingManagmentVacations()
        
        
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pendingManagmentVacationPresenter.getPendingManagmentVacations()
    }
    func viewManagmentPendingVacations(vacationList: [Vacation]) {
        
        if(vacationList.count > 0){
            pendingManagmentVacationTableView.isHidden = false
            noPendingVacationManagmentLabel?.isHidden = true
            pendingManagmentVacationDataSource.vacationList.removeAll()
            pendingManagmentVacationDataSource.vacationList.insert(contentsOf: vacationList, at: 0)
            self.pendingManagmentVacationTableView.reloadData()
        }else{
            pendingManagmentVacationTableView.isHidden = true
            noPendingVacationManagmentLabel?.isHidden = false
            
        }
        
        
    }
    
    
    func onPendingManagmentVacationProgress(state: Bool) {
        if (state){
            super.startProgress()
        }else{
            super.stopProgress()
        }
    }
    
    
    func onPendingManagmentVacationApproved(vacation: Vacation, state: Bool) {
        if(state){
            pendingManagmentVacationDataSource.removeVacation(vacation: vacation,tableView:pendingManagmentVacationTableView)
            if(pendingManagmentVacationDataSource.vacationList.count <= 0){
                noPendingVacationManagmentLabel.isHidden = false
            }else{
                noPendingVacationManagmentLabel.isHidden = true
                
            }
        }else{
            showAlert(withTitle: "error".localiz(), message: "error_Approving_vacation".localiz())
        }
    }
    
    func onPendingManagmentVacationRejected(vacation: Vacation, state: Bool) {
        if(state){
            pendingManagmentVacationDataSource.removeVacation(vacation: vacation,tableView:pendingManagmentVacationTableView)
            if(pendingManagmentVacationDataSource.vacationList.count <= 0){
                noPendingVacationManagmentLabel.isHidden = false
            }else{
                noPendingVacationManagmentLabel.isHidden = true
                
            }
        }else{
            showAlert(withTitle: "error".localiz(), message: "Error Rejecting Vacation".localiz())
        }
        
        
    }
    
    
    
    func viewError(msg: String) {
        //                noPendingVacationManagmentLabel?.isHidden = false
    }
    
}


extension PendingManagmentViewController:VacationManagmentCellProtocol{
    func onPendingVacationManagmentApproveClick(vacation: Vacation, indexPath: IndexPath) {
        self.pendingManagmentVacationPresenter.approvePendingVacation(vacation: vacation)
    }
    
    func onPendingVacationManagmentRejectClick(vacation: Vacation, indexPath: IndexPath) {
        
        let rejectReasonPopUpViewViewController = RejectReasonPopUpViewViewController(rejectedVacation: vacation, rejectVacationPopUptDialogDelegate: self)
        rejectReasonPopUpViewViewController.modalTransitionStyle = .crossDissolve
        rejectReasonPopUpViewViewController.modalPresentationStyle = .overCurrentContext
        self.present(rejectReasonPopUpViewViewController,animated: true,completion: nil)
        
    }
}

extension PendingManagmentViewController : RejectVacationPopUptDialogDelegate{
    func onConfirm(vacation:Vacation,reason: String) {
        self.pendingManagmentVacationPresenter.rejectPendingVacation(vacation: vacation, vacationReason :reason )
    }
    
    func onCancel() {
        
    }
    
    
}
