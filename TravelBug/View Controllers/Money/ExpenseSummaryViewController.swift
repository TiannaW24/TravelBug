//
//  ExpenseSummaryViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/22/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class ExpenseSummaryViewController: UIViewController {

    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //UI Elements
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var travelLabel: UILabel!
    @IBOutlet var lodgingLabel: UILabel!
    @IBOutlet var medicalLabel: UILabel!
    @IBOutlet var entertainmentLabel: UILabel!
    @IBOutlet var shoppingLabel: UILabel!
    @IBOutlet var otherLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set the labels
        foodLabel.text! = String(getExpensesTotalFromCategory(category: "Food"))
        travelLabel.text! = String(getExpensesTotalFromCategory(category: "Travel"))
        lodgingLabel.text! = String(getExpensesTotalFromCategory(category: "Lodging"))
        medicalLabel.text! = String(getExpensesTotalFromCategory(category: "Medical"))
        entertainmentLabel.text! = String(getExpensesTotalFromCategory(category: "Entertainment"))
        shoppingLabel.text! = String(getExpensesTotalFromCategory(category: "Shopping"))
        otherLabel.text! = String(getExpensesTotalFromCategory(category: "Other"))
        totalLabel.text! = String(getExpensesTotalFromCategory(category: "All"))
    }

    func getExpensesTotalFromCategory(category: String) -> Double {
        var total = 0.00
        let keys = applicationDelegate.dict_ExpenseName_ExpenseData.allValues as! Array<Array<String>>
        
        for key in keys {
            if ((key[1] == category) || (category == "All")) {
                let cost = Double(key[0])
                total += cost!
            }
        }
        
        return total
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
