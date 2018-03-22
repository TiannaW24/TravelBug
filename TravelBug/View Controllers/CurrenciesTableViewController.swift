//
//  CurrenciesTableViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/21/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class CurrenciesTableViewController: UITableViewController {

    // Instance variable holding the object reference of the UITableView UI object created in the Storyboard
    @IBOutlet var currenciesTableView: UITableView!
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let MINT_CREAM = UIColor(red: 245.0/255.0, green: 255.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    let OLD_LACE = UIColor(red: 253.0/255.0, green: 245.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    let tableViewRowHeight: CGFloat = 70.0
    
    //Contains currency IDs
    var currencyIDs = [String()]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        currencyIDs = applicationDelegate.dict_CurrencyID_CurrencyData.allKeys as! [String]
        
        // Sort the stock symbols within itself in alphabetical order
        currencyIDs.sort { $0 < $1 }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     --------------------------------------
     MARK: - Table View Data Source Methods
     --------------------------------------
     */
    
    // Return Number of Sections in Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return Number of Rows in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyIDs.count
    }

    //-------------------------------------
    // Prepare and Return a Table View Cell
    //-------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowNumber = (indexPath as NSIndexPath).row
        
        // Obtain the object reference of a reusable table view cell object instantiated under the identifier
        // Currency Cell, which was specified in the storyboard
        let cell: CurrenciesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Currency Cell") as! CurrenciesTableViewCell
        
        // Obtain the ID of the given currency
        let givenCurrencyID = currencyIDs[rowNumber]
        
        // Obtain the list of data values of the given curreny as AnyObject
        let currencyDataObtained: AnyObject? = applicationDelegate.dict_CurrencyID_CurrencyData[givenCurrencyID] as AnyObject
        
        // Typecast the AnyObject to Swift array of String objects
        var currencyData = currencyDataObtained! as! [String]
        
        /*
         currencyData = [currencyName, countryName, countryID]
         */
        
        // Set Cuontry flag image
        let url = URL(string: "http://www.countryflags.io/\(currencyData[2])/flat/64.png")
        let logoImageData = try? Data(contentsOf: url!)
        
        if let imageData = logoImageData {
            cell.countryFlagImageView!.image = UIImage(data: imageData)
        } else {
            //cell.countryFlagImageView!.image = UIImage(named: "logoUnavailable.png")
        }
        
        // Set Currency's Symbol
        cell.currencySymbolLabel!.text = givenCurrencyID
        
        // Set Currency's Name
        cell.currencyNameLabel!.text = currencyData[0]
        
        // Set Currency's Country
        cell.countryNameLabel!.text = currencyData[1]
        
        return cell
    }
    
    /*
     -----------------------------------
     MARK: - Table View Delegate Methods
     -----------------------------------
     */
    
    // Asks the table view delegate to return the height of a given row.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableViewRowHeight
    }
    
    /*
     Informs the table view delegate that the table view is about to display a cell for a particular row.
     Just before the cell is displayed, we change the cell's background color as MINT_CREAM for even-numbered rows
     and OLD_LACE for odd-numbered rows to improve the table view's readability.
     */
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /*
         The remainder operator (RowNumber % 2) computes how many multiples of 2 will fit inside RowNumber
         and returns the value, either 0 or 1, that is left over (known as the remainder).
         Remainder 0 implies even-numbered rows; Remainder 1 implies odd-numbered rows.
         */
        if indexPath.row % 2 == 0 {
            // Set even-numbered row's background color to MintCream, #F5FFFA 245,255,250
            cell.backgroundColor = MINT_CREAM
            
        } else {
            // Set odd-numbered row's background color to OldLace, #FDF5E6 253,245,230
            cell.backgroundColor = OLD_LACE
        }
    }
}
