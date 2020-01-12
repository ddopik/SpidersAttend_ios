//
//  RejectedViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 12/15/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit

class RejectedViewController:BaseViewController{
    
    
    @IBOutlet weak var rejectedVacationTableView: UITableView!
    var rejectedVacationPresenter :RejectedVacationPresenter!
    var rejectedVacationDataSource: VacationDataSource!
    
    @IBOutlet weak var noRejectedVacationTitle: UILabel!
    
    
    @IBOutlet weak var rejectedTabBarItem: UITabBarItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noRejectedVacationTitle.text = "no Rejected vacation available".localiz()
        rejectedVacationPresenter = RejectedVacationPresenterImpl(rejectedControllerView: self)
        rejectedVacationDataSource =  VacationDataSource(vacationType: VacationDataSource.VacationListType.REJECTED)
        
        
        self.rejectedVacationTableView.dataSource = rejectedVacationDataSource
        self.rejectedVacationTableView.delegate = rejectedVacationDataSource!
        self.rejectedVacationTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rejectedVacationPresenter.getRejectedVacation()
    }
    
    
    
}

extension RejectedViewController : RejectedVacationControllerView{
    func onRejectedVacationProgress(state: Bool) {
        if (state){
            super.startProgress()
        }else{
            super.stopProgress()
        }
    }
    
    func viewRejectedVacations(vacationList: [Vacation]) {
        noRejectedVacationTitle.isHidden = true
        rejectedVacationDataSource.vacationList.removeAll()
        rejectedVacationDataSource.vacationList.insert(contentsOf: vacationList, at: 0)
        self.rejectedVacationTableView.reloadData()
        
    }
    
    func viewError(msg: String) {
        noRejectedVacationTitle.isHidden = false
    }
}
