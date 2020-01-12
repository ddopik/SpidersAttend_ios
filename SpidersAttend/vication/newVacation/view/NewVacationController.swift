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

    
    
    

    
    
    @IBOutlet weak var mainContainer: UIStackView!
    
    
    @IBOutlet weak var vacationReasonTitle: UILabel!
    
    @IBOutlet weak var startDateTitle: UILabel!
    
    @IBOutlet weak var endDateTitle: UILabel!
    
    @IBOutlet weak var chooseManagerTitle: UILabel!
    
    @IBOutlet weak var chooseVacationTypeTitle: UILabel!
    
    
    @IBOutlet weak var vacationReasonLabel: UITextField!
    
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

        setInputsLocalization()
        setViewListeners()
        newVacationControllerPresenter.getVacationData()
    }
    
    
    
    @objc func onStartDateLabelClick(sender:UITapGestureRecognizer) {
        self.mainContainer.isUserInteractionEnabled = false
        let startDateDelegate = {
            (date: Date)  ->() in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyy.M.d"
            let dateVal = dateFormat.string(from: date)
            self.startDateUiLabel.text = "  "+dateVal.replacingOccurrences(of: ".", with: "-")
            self.startDate = date
             self.mainContainer.isUserInteractionEnabled = true

        }
        let newVacationDatePackerView =  NewVacationDatePackerView.getInstance(parentView :self.view ,dele: startDateDelegate)
        newVacationDatePackerView.newVacationDatePackerViewDelegate = self
        newVacationDatePackerView.showDatePickerDialog(parentView: self.view)
        
     }
    @objc func onEndDateLabelClick(sender:UITapGestureRecognizer) {
        self.mainContainer.isUserInteractionEnabled = false
        let endDateDelegate = {
            (date: Date)  ->() in
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyy.M.d"
            let dateVal = dateFormat.string(from: date)
            self.endDateLabel.text = "  "+dateVal.replacingOccurrences(of: ".", with: "-")
            self.EndDate = date
            self.mainContainer.isUserInteractionEnabled = true

        }
        
        let newVacationDatePackerView =  NewVacationDatePackerView.getInstance(parentView :self.view ,dele:  endDateDelegate)
        newVacationDatePackerView.newVacationDatePackerViewDelegate = self
        newVacationDatePackerView.showDatePickerDialog(parentView: self.view)
    }
    @objc func onChooseManagerViewClick(_ sender: UITextField) {
        
        self.performSegue(withIdentifier: "managers_search_controller", sender: nil)
        
    }
    @objc func onChooseVacationViewClick(_ sender: UITextField) {
        
        self.performSegue(withIdentifier: "vations_type_search_controller", sender: nil)
        
    }
    
    @IBAction func OnSendVacationSend(_ sender: Any) {
        
        if( validateForm() ){
            
            var  newVacationObj = NewVacationObj()
            newVacationObj.vacationReason = vacationReasonLabel.text
            newVacationObj.vacationStartDate =  endDateLabel.text?.trimmingCharacters(in: .whitespaces)
            newVacationObj.vacationEndDate =  startDateUiLabel.text?.trimmingCharacters(in: .whitespaces)
            newVacationObj.vacationManager =  selectedManager.id
            newVacationObj.vacationType =  selectedVacationType.id
            newVacationControllerPresenter.sendNewVacationRequest(newVacationObj: newVacationObj)
        }
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
    
    func onVacationCreated(state: Bool) {
        if(state){
            navigationController?.popViewController(animated: true)
            showAlert(withTitle: "", message: "Vacation Created successful".localiz())
        }
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
        mainContainer.isUserInteractionEnabled = true

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
        
        if(vacationReasonLabel.text?.isEmpty == true ){
              vacationReasonTitle.textColor = UIColor.red
             state = false
        }else {
              state = true
               vacationReasonTitle.textColor = UIColor.darkGray
        }
        
        if(startDate == nil){
              startDateTitle.textColor = UIColor.red
            state = false
        }else {
            startDateTitle.textColor = UIColor.darkGray

              state = true
        }
        
        
        if(EndDate == nil ){
             endDateTitle.textColor = UIColor.red
            state = false
        }else {
               endDateTitle.textColor = UIColor.darkGray
              state = true
        }
        
        
        if(self.EndDate != nil && self.startDate != nil ){
            
            if(self.EndDate.timeIntervalSince(self.startDate) < 0 ){
                showAlert(withTitle: "Error".localiz(), message: "Vacation End Date Should not be before start Date".localiz())
                 endDateTitle.textColor = UIColor.red
                   state = false
            }else {
                endDateTitle.textColor = UIColor.darkGray
                  state = true
            }
        }
  
        
        if(selectedManager == nil){
              chooseManagerTitle.textColor = UIColor.red
            state = false
        }else {
            chooseManagerTitle.textColor = UIColor.darkGray
              state = true
        }
        
        if(selectedVacationType == nil){
             chooseVacationTypeTitle.textColor = UIColor.red
            state = false
        }else {
            chooseVacationTypeTitle.textColor = UIColor.darkGray

              state = true
        }
        
        
        return state
    }
    
    
    private func setInputsLocalization(){
        
        
        vacationReasonTitle.text = "Vacation Reason".localiz()
        
        startDateTitle.text = "Start Date".localiz()
        
        endDateTitle.text = "End Date".localiz()
        
        chooseManagerTitle.text = "Choose Manager".localiz()
        
        chooseVacationTypeTitle.text = "Choose vacation Type".localiz()
        
        
        
        vacationReasonLabel.placeholder = "Reason".localiz()
        
        startDateUiLabel.text = "Start Date".localiz()
        
        endDateLabel.text = "End Date".localiz()
        
        chooseManagerLabel.text = "Manager".localiz()
        
        chooseVacationTypeLabel.text = "Vacation Type".localiz()
        
    }
}


 
    
    

 
