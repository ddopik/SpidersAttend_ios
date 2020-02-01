
//
//  RejectedManagmentViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 1/16/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class RejectedManagmentViewController :BaseViewController{

          @IBOutlet weak var rejevtedVacationTableView: UITableView!
            var rejectedManagmentVacationPresenter : RejectedManagmentPresenter!
            var rejectedManagmentVacationDataSource: VacationDataSource!
            
            
            @IBOutlet weak var noManagmentRejectedVacationTitle: UILabel!
            
     
            
            
            override func viewDidLoad() {
                super.viewDidLoad()
                
                noManagmentRejectedVacationTitle.text = "No Managment Rejected vacation available".localiz()
                rejectedManagmentVacationPresenter = RejectedManagmentPresenterImpl(rejectedManagmentView: self)
                rejectedManagmentVacationDataSource =  VacationDataSource(vacationType: VacationDataSource.VacationListType.REJECTED)
                
         
                self.rejevtedVacationTableView.dataSource = rejectedManagmentVacationDataSource
                self.rejevtedVacationTableView.delegate = rejectedManagmentVacationDataSource!
                
                self.rejevtedVacationTableView.tableFooterView = UIView(frame: CGRect.zero)
            }
        
        
        
    //
            override func viewDidAppear(_ animated: Bool) {
                super.viewDidAppear(animated)
                rejectedManagmentVacationPresenter.getRejectedManagmentVacations()
            }

          
            
        }

    extension RejectedManagmentViewController : RejectedManagmentView {
      
        
            func onRejectedManagmentVacationProgress(state: Bool) {
                 if (state){
                          super.startProgress()
                      }else{
                          super.stopProgress()
                      }
            }

            func viewManagmentRejectedVacations(vacationList: [Vacation]) {
                
                if (vacationList.count > 0 ){
                    rejevtedVacationTableView.isHidden = false
                    noManagmentRejectedVacationTitle.isHidden = true
                    rejectedManagmentVacationDataSource.vacationList.removeAll()
                      rejectedManagmentVacationDataSource.vacationList.insert(contentsOf: vacationList, at: 0)
                      self.rejevtedVacationTableView.reloadData()
                }else {
                    rejevtedVacationTableView.isHidden = true
                                    noManagmentRejectedVacationTitle.isHidden = false
                }


              }

            func viewError(msg: String) {
                noManagmentRejectedVacationTitle.isHidden = false
            }
        }


