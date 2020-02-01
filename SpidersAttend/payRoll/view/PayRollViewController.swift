//
//  PayRollViewController.swift
//  SpidersAttend
//
//  Created by ddopik on 8/7/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import UIKit

class PayRollViewController: BaseViewController,PayRollViewControllerView {

    @IBOutlet weak var payRollTableView: UITableView!
    private var payRollDataSource:PayRollDataSource!
    private var payRollPresenter:PayRollPresenter!
    
    let PAY_ROLL_DETAILS_SEQUE = "payRoll_details_sque"
    
    @IBOutlet weak var noPayRollDataStatsTitle: UILabel!
     override func viewDidLoad() {
        super.viewDidLoad()
        payRollDataSource = PayRollDataSource()
        payRollDataSource.payRollDataSourceDelegate = self
        payRollTableView.dataSource = payRollDataSource
        payRollTableView.delegate = payRollDataSource
        self.payRollTableView.tableFooterView = UIView(frame: CGRect.zero)

        payRollPresenter = PayRollPresenterImp(payRollViewControllerView: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noPayRollDataStatsTitle.text = "No PayRoll data avaialaible".localiz()
        payRollPresenter.getPayRollData()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == PAY_ROLL_DETAILS_SEQUE)    {
            let payRollDetails = segue.destination as! PayRollDetailViewController
            payRollDetails.setPayRollData(payRoll : sender as! Payroll)
        }
    }
}

extension PayRollViewController{
       func viewPayRoll(payRollList: [Payroll]) {
        if(payRollList.count > 0 ){
            payRollDataSource.setPayRollList(payRollList: payRollList)
            payRollTableView.reloadData()
            noPayRollDataStatsTitle?.isHidden = true

        }else{
             noPayRollDataStatsTitle?.isHidden = false
        }

       }
       
       func viewProgress(state: Bool) {
        if state{
            super.progressView.isHidden = false
        }else{
            super.progressView.isHidden = true

        }
       }
       
       func viewError(msg: String) {
        super.showAlert(withTitle: "Error".localiz(), message: msg)
        self.noPayRollDataStatsTitle?.isHidden = false
       }
       
}


extension PayRollViewController: PayRollDataSourceDelegate{
    func onPayRollClick(payRoll: Payroll) {
        performSegue(withIdentifier: PAY_ROLL_DETAILS_SEQUE, sender: payRoll)
    }
    
    
}
