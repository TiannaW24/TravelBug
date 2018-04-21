//
//  ExpenseInfoViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/22/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class ExpenseInfoViewController: UIViewController {

    //UI Elements to be set
    @IBOutlet var expenseNameLabel: UILabel!
    @IBOutlet var expenseCategoryLabel: UILabel!
    @IBOutlet var expenseBudgetedLabel: UILabel!
    @IBOutlet var expenseAmountLabel: UILabel!
    @IBOutlet var expenseBudgetedImageView: UIImageView!
    
    //Instance variables
    // [expenseAmount, expenseCategory, expenseBudgeted, expenseName]
    var expensePassed = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the UI elements according to the data passed in
        expenseNameLabel.text! = expensePassed[3]
        expenseCategoryLabel.text! = expensePassed[1]
        expenseAmountLabel.text! = expensePassed[0]
        
        if (expensePassed[2] == "Yes") {
            expenseBudgetedLabel.text! = "You budgeted for this expense"
            expenseBudgetedImageView.image = UIImage(named: "CheckMark")
        }
        else {
            expenseBudgetedLabel.text! = "You did not budget for this expense"
            expenseBudgetedImageView.image = UIImage(named: "XMark")
        }
        
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
        
        //Labels
        expenseNameLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 30)
        expenseAmountLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 28)
        expenseCategoryLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        expenseBudgetedLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 17)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
