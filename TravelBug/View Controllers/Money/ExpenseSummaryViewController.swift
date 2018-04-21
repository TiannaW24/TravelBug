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
    @IBOutlet var foodSumLabel: UILabel!
    @IBOutlet var travelSumLabel: UILabel!
    @IBOutlet var lodgingSumLabel: UILabel!
    @IBOutlet var medicalSumLabel: UILabel!
    @IBOutlet var entertainmentSumLabel: UILabel!
    @IBOutlet var shoppingSumLabel: UILabel!
    @IBOutlet var otherSumLabel: UILabel!
    @IBOutlet var totalSumLabel: UILabel!
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
        foodSumLabel.text! = String(getExpensesTotalFromCategory(category: "Food"))
        foodSumLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        foodSumLabel.textColor = UIColor.white
        travelSumLabel.text! = String(getExpensesTotalFromCategory(category: "Travel"))
        travelSumLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        travelSumLabel.textColor = UIColor.white
        lodgingSumLabel.text! = String(getExpensesTotalFromCategory(category: "Lodging"))
        lodgingSumLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        lodgingSumLabel.textColor = UIColor.white
        medicalSumLabel.text! = String(getExpensesTotalFromCategory(category: "Medical"))
        medicalSumLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        medicalSumLabel.textColor = UIColor.white
        entertainmentSumLabel.text! = String(getExpensesTotalFromCategory(category: "Entertainment"))
        entertainmentSumLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        entertainmentSumLabel.textColor = UIColor.white
        shoppingSumLabel.text! = String(getExpensesTotalFromCategory(category: "Shopping"))
        shoppingSumLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        shoppingSumLabel.textColor = UIColor.white
        otherSumLabel.text! = String(getExpensesTotalFromCategory(category: "Other"))
        otherSumLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        otherSumLabel.textColor = UIColor.white
        totalSumLabel.text! = String(getExpensesTotalFromCategory(category: "All"))
        totalSumLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 25)
        totalSumLabel.textColor = UIColor.white
        foodLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 22)
        travelLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 22)
        lodgingLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 22)
        medicalLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 22)
        entertainmentLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 22)
        shoppingLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 22)
        otherLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 22)
        totalLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 22)
        
        //Tab Bar
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        
        contentView.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.width, height: 750)
        scrollView.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
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
