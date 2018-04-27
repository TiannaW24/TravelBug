//
//  CurrenciesTableViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/21/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class CurrenciesTableViewController: UITableViewController, UISearchResultsUpdating {

    // Instance variable holding the object reference of the UITableView UI object created in the Storyboard
    @IBOutlet var currenciesTableView: UITableView!
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let MINT_CREAM = UIColor(red: 165.0/255.0, green: 216.0/255.0, blue: 237.0/255.0, alpha: 1.0)
    let OLD_LACE = UIColor(red: 227.0/255.0, green: 197.0/255.0, blue: 245.0/255.0, alpha: 1.0)
    let tableViewRowHeight: CGFloat = 70.0
    
    //Instance variables
    var countryNames = [String()]
    var searchResults = [String]()
    var searchResultsController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        countryNames = applicationDelegate.dict_CountryName_CountryData.allKeys as! [String]
        
        // Sort the stock symbols within itself in alphabetical order
        countryNames.sort { $0 < $1 }
        
        // Create a Search Results Controller object for the Search Bar
        createSearchResultsController()
    }
    
    /*
     ---------------------------------------------
     MARK: - Creation of Search Results Controller
     ---------------------------------------------
     */
    func createSearchResultsController() {
        /*
         Instantiate a UISearchController object and store its object reference into local variable: controller.
         Setting the parameter searchResultsController to nil implies that the search results will be displayed
         in the same view used for searching (under the same UITableViewController object).
         */
        let controller = UISearchController(searchResultsController: nil)
        
        /*
         We use the same table view controller (self) to also display the search results. Therefore,
         set self to be the object responsible for listing and updating the search results.
         Note that we made self to conform to UISearchResultsUpdating protocol.
         */
        controller.searchResultsUpdater = self
        
        /*
         The property dimsBackgroundDuringPresentation determines if the underlying content is dimmed during
         presentation. We set this property to false since we are presenting the search results in the same
         view that is used for searching. The "false" option displays the search results without dimming.
         */
        controller.dimsBackgroundDuringPresentation = false
        
        // Resize the search bar object based on screen size and device orientation.
        controller.searchBar.sizeToFit()
        
        /***************************************************************************
         No need to create the search bar in the Interface Builder (storyboard file).
         The statement below creates it at runtime.
         ***************************************************************************/
        
        // Set the tableHeaderView's accessory view displayed above the table view to display the search bar.
        self.tableView.tableHeaderView = controller.searchBar
        
        /*
         Set self (Table View Controller) define the presentation context so that the Search Bar subview
         does not show up on top of the view (scene) displayed by a downstream view controller.
         */
        self.definesPresentationContext = true
        
        /*
         Set the object reference (controller) of the newly created and dressed up UISearchController
         object to be the value of the instance variable searchResultsController.
         */
        searchResultsController = controller
    }
    
    /*
     -----------------------------------------------
     MARK: - UISearchResultsUpdating Protocol Method
     -----------------------------------------------
     
     This UISearchResultsUpdating protocol required method is automatically called whenever the search
     bar becomes the first responder or changes are made to the text or scope of the search bar.
     You must perform all required filtering and updating operations inside this method.
     */
    func updateSearchResults(for searchController: UISearchController)
    {
        // Empty the instance variable searchResults array without keeping its capacity
        searchResults.removeAll(keepingCapacity: false)
        
        // Set searchPredicate to search for any character(s) the user enters into the search bar.
        // [c] indicates that the search is case insensitive.
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        // Obtain the country names that contain the character(s) the user types into the Search Bar.
        let arrayOfCountriesFound = (countryNames as NSArray).filtered(using: searchPredicate)
        
        // Obtain the search results as an array of type String
        searchResults = arrayOfCountriesFound as! [String]
        
        // Reload the table view to display the search results
        self.tableView.reloadData()
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
        // Use the Ternary Conditional Operator to concisely represent the IF statement below.
        return searchResultsController.isActive ? searchResults.count : countryNames.count
    }

    //-------------------------------------
    // Prepare and Return a Table View Cell
    //-------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowNumber = (indexPath as NSIndexPath).row
        
        // Currency Cell, which was specified in the storyboard
        let cell: CurrenciesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Currency Cell") as! CurrenciesTableViewCell
        var givenCountryName = String()
        
        //Determine where to get givenCurrencyID from
        if (!searchResultsController.isActive) {
            // Obtain the ID of the given currency from the overall array
            givenCountryName = countryNames[rowNumber]
        }
        else {
            //Obtain the ID of the given currency from the searchResults array
            givenCountryName = searchResults[rowNumber]
        }
        
        // Obtain the list of data values of the given curreny as AnyObject
        let currencyDataObtained: AnyObject? = applicationDelegate.dict_CountryName_CountryData[givenCountryName] as AnyObject
        
        // Typecast the AnyObject to Swift array of String objects
        //  currencyData = [countryID, currencyName, currencyID]
        var currencyData = currencyDataObtained! as! [String]
        
        // Set Country flag image
        let url = URL(string: "http://www.countryflags.io/\(currencyData[0])/flat/64.png")
        let logoImageData = try? Data(contentsOf: url!)
        
        if let imageData = logoImageData {
            cell.countryFlagImageView!.image = UIImage(data: imageData)
        } else {
            //cell.countryFlagImageView!.image = UIImage(named: "logoUnavailable.png")
        }
        
        //[countryID, currencyName, currencyID]
        // Set Currency's Symbol
        cell.currencySymbolLabel!.text = currencyData[2]
        
        // Set Currency's Name
        cell.currencyNameLabel!.text = currencyData[1]
        
        // Set Currency's Country
        cell.countryNameLabel!.text = givenCountryName
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
