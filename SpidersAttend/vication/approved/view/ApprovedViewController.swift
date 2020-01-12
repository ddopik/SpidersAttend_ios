//
//  ApprovedViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 12/15/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class ApprovedViewController:BaseViewController{
    
    
    @IBOutlet weak var approvedVacationTableView: UITableView!
    var approvedVacationPresenter :ApprovedVacationPresenter!
    var approvedVacationDataSource: VacationDataSource!
    
    
    @IBOutlet weak var noApprovedVacationTitle: UILabel!
    
    @IBOutlet weak var approvedTabBarItem: UITabBarItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noApprovedVacationTitle.text = "no Approved vacation available".localiz()
        approvedVacationPresenter = ApprovedVacationPresenterImpl(approvedVacationView: self)
        approvedVacationDataSource =  VacationDataSource(vacationType: VacationDataSource.VacationListType.APPROVED)
        
 
        self.approvedVacationTableView.dataSource = approvedVacationDataSource
        self.approvedVacationTableView.delegate = approvedVacationDataSource!
        
        self.approvedVacationTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        approvedVacationPresenter.getApprovedVacation()
    }
    
  
    
}

extension ApprovedViewController : ApprovedVacationView{
    func onApprovedVacationProgress(state: Bool) {
         if (state){
                  super.startProgress()
              }else{
                  super.stopProgress()
              }
    }
    
    func viewApprovedVacations(vacationList: [Vacation]) {
        noApprovedVacationTitle.isHidden = true
        approvedVacationDataSource.vacationList.removeAll()
          approvedVacationDataSource.vacationList.insert(contentsOf: vacationList, at: 0)
          self.approvedVacationTableView.reloadData()
          
      }
    
    func viewError(msg: String) {
        noApprovedVacationTitle.isHidden = false
    }
}
