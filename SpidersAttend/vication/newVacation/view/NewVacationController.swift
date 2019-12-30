//
//  NewVacationController.swift
//  SpidersAttend
//
//  Created by ddopik on 12/26/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class NewVacationController :BaseViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var startDateTextView: UITextField!
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        self.navigationController?.navigationBarHidden = true
        startDateTextView.delegate = self
    }
    
//    @IBAction func startDateTextViewAction(_ sender: Any) {
//        startDatePickerView.isHidden = false
//
//    }
    

    func textFieldDidBeginEditing(_ textField: UITextField) {
          if textField == self.startDateTextView {
         /// call date Picker here
            _ = NewVacationDatePackerView(parentView: self.view).showDatePickerDialog()
  
          }
      }
    
 
    
 
    
   

}
extension NewVacationController : NewVacationDatePackerViewDelegate{
    func onDateSelected(date: String)  {
         
    }
    
    func onDateDismessed() {
         
    }
    
    
}

 
