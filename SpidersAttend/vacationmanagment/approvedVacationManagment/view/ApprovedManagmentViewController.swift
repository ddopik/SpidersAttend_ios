//
//  ApprovedManagmentViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 1/16/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class ApprovedManagmentViewController : BaseViewController {
    
    
      @IBOutlet weak var approvedVacationTableView: UITableView!
        var approvedManagmentVacationPresenter : ApprovedManagmentPresenter!
        var approvedManagmentVacationDataSource: VacationDataSource!
        
        
        @IBOutlet weak var noManagmentApprovedVacationTitle: UILabel!
        
 
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            noManagmentApprovedVacationTitle.text = "No Managment Approved vacation available".localiz()
            approvedManagmentVacationPresenter = ApprovedManagmentPresenterImpl(approvedManagmentView: self)
            approvedManagmentVacationDataSource =  VacationDataSource(vacationType: VacationDataSource.VacationListType.APPROVED)
            
     
            self.approvedVacationTableView.dataSource = approvedManagmentVacationDataSource
            self.approvedVacationTableView.delegate = approvedManagmentVacationDataSource!
            
            self.approvedVacationTableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    
    
    
//
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            approvedManagmentVacationPresenter.getApprovedManagmentVacations()
        }

      
        
    }

extension ApprovedManagmentViewController : ApprovedManagmentView {
  
    
        func onApprovedManagmentVacationProgress(state: Bool) {
             if (state){
                      super.startProgress()
                  }else{
                      super.stopProgress()
                  }
        }

        func viewManagmentApprovedVacations(vacationList: [Vacation]) {
            
            if (vacationList.count > 0){
                approvedVacationTableView.isHidden = false
                noManagmentApprovedVacationTitle.isHidden = true
                     approvedManagmentVacationDataSource.vacationList.removeAll()
                       approvedManagmentVacationDataSource.vacationList.insert(contentsOf: vacationList, at: 0)
                       self.approvedVacationTableView.reloadData()
            }else{
                approvedVacationTableView.isHidden = true
                 noManagmentApprovedVacationTitle.isHidden = false
            }
            
     

          }

        func viewError(msg: String) {
            noManagmentApprovedVacationTitle.isHidden = false
        }
    }


