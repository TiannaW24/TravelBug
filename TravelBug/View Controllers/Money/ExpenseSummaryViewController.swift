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
    @IBOutlet var contentView: UIView!
    @IBOutlet var scrollView: UIScrollView!
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
        foodLabel.font = UIFont (name: "Avenir-LightOblique", size: 20)
        foodLabel.textColor = UIColor.white
        travelLabel.text! = String(getExpensesTotalFromCategory(category: "Travel"))
        travelLabel.font = UIFont (name: "Avenir-LightOblique", size: 20)
        travelLabel.textColor = UIColor.white
        lodgingLabel.text! = String(getExpensesTotalFromCategory(category: "Lodging"))
        lodgingLabel.font = UIFont (name: "Avenir-LightOblique", size: 20)
        lodgingLabel.textColor = UIColor.white
        medicalLabel.text! = String(getExpensesTotalFromCategory(category: "Medical"))
        medicalLabel.font = UIFont (name: "Avenir-LightOblique", size: 20)
        medicalLabel.textColor = UIColor.white
        entertainmentLabel.text! = String(getExpensesTotalFromCategory(category: "Entertainment"))
        entertainmentLabel.font = UIFont (name: "Avenir-LightOblique", size: 20)
        entertainmentLabel.textColor = UIColor.white
        shoppingLabel.text! = String(getExpensesTotalFromCategory(category: "Shopping"))
        shoppingLabel.font = UIFont (name: "Avenir-LightOblique", size: 20)
        shoppingLabel.textColor = UIColor.white
        otherLabel.text! = String(getExpensesTotalFromCategory(category: "Other"))
        otherLabel.font = UIFont (name: "Avenir-LightOblique", size: 20)
        otherLabel.textColor = UIColor.white
        totalLabel.text! = String(getExpensesTotalFromCategory(category: "All"))
        totalLabel.font = UIFont (name: "Avenir-LightOblique", size: 25)
        totalLabel.textColor = UIColor.white
        
        //Tab Bar
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        
        //Background
        let bgImage = UIImage(named: "blue_purple_background")
        let bgImageView = UIImageView()
        bgImageView.frame = contentView.frame
        bgImageView.image = bgImage
        bgImageView.alpha = 0.5
        contentView.addSubview(bgImageView)
        contentView.sendSubview(toBack: bgImageView)
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
