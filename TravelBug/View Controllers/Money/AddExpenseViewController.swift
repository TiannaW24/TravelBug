//
//  FundTrackerEntryViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/21/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //UI Elements
    @IBOutlet var expenseTitleTextField: UITextField!
    @IBOutlet var expenseCategoryPicker: UIPickerView!
    @IBOutlet var expenseAmountTextField: UITextField!
    @IBOutlet var expenseBudgetedSegControl: UISegmentedControl!
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Instance variables
    var expenseCategories: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SET UP CATEGORY PICKER
        expenseCategoryPicker.delegate = self
        expenseCategories = ["Food", "Travel", "Lodging", "Medical", "Entertainment", "Shopping", "Other"]
        
        //Tab Bar
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        
        //Background
        let bgImage = UIImage(named: "blue_purple_background")
        let bgImageView = UIImageView()
        bgImageView.frame = self.view.frame
        bgImageView.image = bgImage
        bgImageView.alpha = 0.5
        self.view.addSubview(bgImageView)
        self.view.sendSubview(toBack: bgImageView)
    }
    
    //categoryPicker Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return expenseCategories.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { return expenseCategories[row]
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        //Run input validations
        if (expenseTitleTextField.text! == "") {
            showAlertMessage(messageHeader: "Expense Title Error", messageBody: "Please enter a title for this expense!")
            return
        }
        else if (expenseAmountTextField.text! == "") {
            showAlertMessage(messageHeader: "Expense Amount Error", messageBody: "Please enter an amount for this expense!")
            return
        }
        else if (Double(expenseAmountTextField.text!) == nil) {
            showAlertMessage(messageHeader: "Expense Title Error", messageBody: "Sorry, that is not a valid expense amount!")
            return
        }
        
        //Seg Control options
        let budgetedOptions = [0: "Yes", 1: "No"]

        
        //Create a new expense
        let expenseName = expenseTitleTextField.text!
        let expenseAmount = expenseAmountTextField.text!
        let expenseCategory = expenseCategories[expenseCategoryPicker.selectedRow(inComponent: 0)]
        let expenseBudgeted = budgetedOptions[expenseBudgetedSegControl.selectedSegmentIndex]
        
        let expenseData = [expenseAmount, expenseCategory, expenseBudgeted]
        
        //Add the expense to the dictionary
        applicationDelegate.dict_ExpenseName_ExpenseData.setObject(expenseData, forKey: expenseName as NSCopying)
        
        showAlertMessage(messageHeader: "New Expense", messageBody: "Your \(expenseName) expense was saved! You can view it in the expense list feature or add another expense.")
        
        //Reset the fields
        expenseTitleTextField.text! = ""
        expenseAmountTextField.text! = ""
        
    }
    
    /*
     -----------------------------
     MARK: - Display Alert Message
     -----------------------------
     */
    func showAlertMessage(messageHeader header: String, messageBody body: String) {
        
        /*
         Create a UIAlertController object; dress it up with title, message, and preferred style;
         and store its object reference into local constant alertController
         */
        let alertController = UIAlertController(title: header, message: body, preferredStyle: UIAlertControllerStyle.alert)
        
        // Create a UIAlertAction object and add it to the alert controller
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


