//
//  NewVacationController.swift
//  SpidersAttend
//
//  Created by ddopik on 12/26/19.
//  Copyright © 2019 Brandeda. All rights reserved.
//

import Foundation
import UIKit
class NewVacationController :BaseViewController,NewVacationControllerView  {
    
    
    
    @IBOutlet weak var vacationReason: UITextField!
    
    @IBOutlet weak var startDateUiLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var chooseManagerLabel: UILabel!
    
    @IBOutlet weak var chooseVacationTypeLabel: UILabel!
    
    var startDate,EndDate :Date!
    var selectedManager:User!
    var selectedVacationType:VacationType!
    
    
    var newVacationControllerPresenter:NewVacationControllerPresenter!
    var vacationTypeList : [VacationType]!
    var managersList : [User]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newVacationControllerPresenter = NewVacationControllerPresenterImpl(newVacationControllerView: self)
        
        
        
        setViewListeners()
        
        
        newVacationControllerPresenter.getVacationData()
    }
    
    
    
    @objc func onStartDateLabelClick(sender:UITapGestureRecognizer) {
        let startDateDelegate = {
            (date: Date)  ->() in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "d.M.yyyy"
            let dateVal = dateFormat.string(from: date)
            self.startDateUiLabel.text = "  "+dateVal
            self.startDate = date
        }
        let newVacationDatePackerView =  NewVacationDatePackerView.getInstance(parentView :self.view ,dele: startDateDelegate)
        newVacationDatePackerView.showDatePickerDialog(parentView: self.view)
        
         self.startDateUiLabel.textColor = UIColor.red
    }
    @objc func onEndDateLabelClick(sender:UITapGestureRecognizer) {
        
        let endDateDelegate = {
            (date: Date)  ->() in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "d.M.yyyy"
            let dateVal = dateFormat.string(from: date)
            self.endDateLabel.text = "  "+dateVal
            self.EndDate = date
        }
        
        let newVacationDatePackerView =  NewVacationDatePackerView.getInstance(parentView :self.view ,dele:  endDateDelegate)
        newVacationDatePackerView.showDatePickerDialog(parentView: self.view)
    }
    @objc func onChooseManagerViewClick(_ sender: UITextField) {
        
        self.performSegue(withIdentifier: "managers_search_controller", sender: nil)
        
    }
    @objc func onChooseVacationViewClick(_ sender: UITextField) {
        
        self.performSegue(withIdentifier: "vations_type_search_controller", sender: nil)
        
    }
    
    @IBAction func OnSendVacationSend(_ sender: Any) {
        
        validateForm()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "managers_search_controller" ){
            let searchManagerListViewController = segue.destination as! ManagersSearchViewController
            searchManagerListViewController.setManagersList(managerList: self.managersList)
            searchManagerListViewController.searchMangerListDelegate = self
        }
        
        if(segue.identifier == "vations_type_search_controller" ){
            let vacationTypesSearchViewController = segue.destination as! VacationTypesSearchViewController
            vacationTypesSearchViewController.setVacationTypesList(vacationTypeList: self.vacationTypeList)
            vacationTypesSearchViewController.vacationTypesDelegate = self
            
        }
    }
    private func setLabelsBorders() {
        
        self.startDateUiLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.startDateUiLabel.layer.borderWidth = 0.5
        self.startDateUiLabel.layer.cornerRadius = 8;
        
        self.endDateLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.endDateLabel.layer.borderWidth = 0.5
        self.endDateLabel.layer.cornerRadius = 8;
        
        self.chooseManagerLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.chooseManagerLabel.layer.borderWidth = 0.5
        self.chooseManagerLabel.layer.cornerRadius = 8;
        
        self.chooseVacationTypeLabel.layer.borderColor = UIColor.lightGray.cgColor
        self.chooseVacationTypeLabel.layer.borderWidth = 0.5
        self.chooseVacationTypeLabel.layer.cornerRadius = 8;
    }
    
    private func setViewListeners(){
        
        let startDateOnTap = UITapGestureRecognizer(target: self, action: #selector(onStartDateLabelClick))
        startDateUiLabel.isUserInteractionEnabled = true
        startDateUiLabel.addGestureRecognizer(startDateOnTap)
        /////
        let endDateOnTab = UITapGestureRecognizer(target: self, action: #selector(onEndDateLabelClick))
        endDateLabel.isUserInteractionEnabled = true
        endDateLabel.addGestureRecognizer(endDateOnTab)
        //////
        let chooseManagerOnTab = UITapGestureRecognizer(target: self, action: #selector(onChooseManagerViewClick))
        chooseManagerLabel.isUserInteractionEnabled = true
        chooseManagerLabel.addGestureRecognizer(chooseManagerOnTab)
        /////////
        let chooseVacationOnTab = UITapGestureRecognizer(target: self, action: #selector(onChooseVacationViewClick))
        chooseVacationTypeLabel.isUserInteractionEnabled = true
        chooseVacationTypeLabel.addGestureRecognizer(chooseVacationOnTab)
        /////////
    }
    
}


extension NewVacationController{
    func viewProgress(state: Bool) {
        if state {
            super.progressView.isHidden = false
        }else{
            super.progressView.isHidden = true
            
        }
    }
    
    func viewError(title: String, body: String) {
        showAlert(withTitle: title, message: body)
    }
}


extension NewVacationController{
    func setVacationTypes(vacationTypes: [VacationType]) {
        self.vacationTypeList = vacationTypes
    }
    
    func setManagersList(managersList: [User]) {
        self.managersList = managersList
    }
    
}

extension NewVacationController : NewVacationDatePackerViewDelegate {
    
    
    func onDateDismessed() {
        
    }
}
extension NewVacationController : ManagersSearchDelegate ,VacationTypesDelegate{
    
    
    func onManagerSelected(user:User) {
        chooseManagerLabel.text = "  " + user.name
        selectedManager = user
    }
    func onVacationSelected(vacation: VacationType) {
        chooseVacationTypeLabel.text = "  " + vacation.name
        selectedVacationType = vacation
    }
    
    
    
}

extension NewVacationController {
    private func validateForm() -> Bool {
        
        var state = true
        
        if(vacationReason.text?.isEmpty == true ){
            vacationReason.text =  "Field is Rquired".localiz()
             vacationReason.textColor = UIColor.red
             state = false
        }else {
              state = true
        }
        
        if(startDate == nil){
            startDateUiLabel.text =  "Field is Rquired".localiz()
             startDateUiLabel.textColor = UIColor.red
            state = false
        }else {
              state = true
        }
        
        
        if(EndDate == nil ){
            endDateLabel.text =  "Field is Rquired".localiz()
            endDateLabel.textColor = UIColor.red
            state = false
        }else {
              state = true
        }
        
        
        if(self.EndDate != nil && self.startDate != nil ){
            
            if(self.EndDate.timeIntervalSince(self.startDate) < 0 ){
                  state = false
            }else {
                  state = true
            }
        }
  
        
        if(selectedManager == nil){
            chooseManagerLabel.text =  "Field is Rquired".localiz()
             chooseManagerLabel.textColor = UIColor.red
            state = false
        }else {
              state = true
        }
        
        if(selectedVacationType == nil){
            chooseVacationTypeLabel.text =  "Field is Rquired".localiz()
            chooseVacationTypeLabel.textColor = UIColor.red
            state = false
        }else {
              state = true
        }
        
        
        return state
    }
}


 
    
    

 
