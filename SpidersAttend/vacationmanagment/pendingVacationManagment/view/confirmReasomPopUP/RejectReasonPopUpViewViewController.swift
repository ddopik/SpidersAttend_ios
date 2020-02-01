//
//  RejectReasonPopUpViewViewController.swift
//  SpidersAttend
//
//  Created by Abd Alla maged on 1/29/20.
//  Copyright © 2020 Brandeda. All rights reserved.
//

import UIKit

class RejectReasonPopUpViewViewController: UIViewController {

       var rejectVacationPopUptDialogDelegate :RejectVacationPopUptDialogDelegate!
    var rejectedVacation:Vacation!
    @IBOutlet weak var vacationReasinlabel: UILabel!
    @IBOutlet weak var reasonView: UITextField!
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(rejectedVacation vacation:Vacation,rejectVacationPopUptDialogDelegate:RejectVacationPopUptDialogDelegate) {
        self.rejectedVacation = vacation
        self.rejectVacationPopUptDialogDelegate =  rejectVacationPopUptDialogDelegate
        super.init(nibName: nil, bundle: nil)

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
         vacationReasinlabel.text = "Vacation reason".localiz()
        self.definesPresentationContext = true
        self.view.layer.cornerRadius = 20.0
         self.view.clipsToBounds = true
      }
    
 
    @IBAction func onConfirmClick(_ sender: Any) {
         if(reasonView.text?.count == 0){
            reasonView.attributedPlaceholder = NSAttributedString(string: "Please Specify A reason".localiz(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])

 
              }else {
        reasonView.attributedPlaceholder = NSAttributedString(string: "Reason".localiz(), attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
                  rejectVacationPopUptDialogDelegate?.onConfirm(vacation: rejectedVacation ,reason: reasonView.text!)
                  dismiss(animated: true, completion: nil)
              }
    }
    
    @IBAction func onCancelClick(_ sender: Any) {
        rejectVacationPopUptDialogDelegate?.onCancel()
        dismiss(animated: true, completion: nil)
     }
    
}
protocol RejectVacationPopUptDialogDelegate {
    func onConfirm(vacation:Vacation, reason:String)
    func onCancel()
}
 
