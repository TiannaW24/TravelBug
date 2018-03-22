//
//  MoneyViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/21/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func currencyConverterButtonPressed(_ sender: UIButton) {
        //Transition to currency converter
        performSegue(withIdentifier: "Currency Converter", sender: self)
    }
    
    @IBAction func fundTrackerButtonPressed(_ sender: UIButton) {
        //Transition to fund tracker
        performSegue(withIdentifier: "Fund Tracker Entry", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
