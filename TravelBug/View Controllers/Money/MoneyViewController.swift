//
//  MoneyViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/21/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var currencyButton: UIButton!
    @IBOutlet var addExpenseButton: UIButton!
    @IBOutlet var expenseListButton: UIButton!
    @IBOutlet var expenseSummaryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        //Welcome label and buttons
        welcomeLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 25)
        currencyButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        addExpenseButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        expenseListButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        expenseSummaryButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        
        //Navbar
    }
    
    @IBAction func currencyConverterButtonPressed(_ sender: UIButton) {
        //Transition to currency converter
        performSegue(withIdentifier: "Currency Converter", sender: self)
    }
    

    @IBAction func addExpenseButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Add Expense", sender: self)
    }
    
    @IBAction func listOfExpensesButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Expenses List", sender: self)
    }
    
    @IBAction func viewExpensesSummaryButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Expenses Summary", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
