//
//  ExpenseListViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/22/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class ExpenseListViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate {

    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Object references to the UI objects instantiated in the Storyboard
    @IBOutlet var leftArrowBlack: UIImageView!
    @IBOutlet var rightArrowBlack: UIImageView!
    @IBOutlet var scrollMenu: UIScrollView!
    @IBOutlet var expensesTableView: UITableView!
    
    //Instance variables
    var expenseNames = [String()]
    var expenseToBePassed = [String()]
    var expenseCategories = ["All", "Food", "Travel", "Lodging", "Medical", "Entertainment", "Shopping", "Other"]
    let kScrollMenuHeight: CGFloat = 64.0
    var selectedExpenseType = ""
    var expensesFromSelectedType = [String()]
    var previousButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    let backgroundColorToUse = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // READ FROM THE DICTIONARY
        expenseNames = applicationDelegate.dict_ExpenseName_ExpenseData.allKeys as! [String]
        expenseNames.sort { $0 < $1 }
        
        //Set background colors
        self.view.backgroundColor = UIColor.white
        leftArrowBlack.backgroundColor = UIColor.white
        rightArrowBlack.backgroundColor = UIColor.white
        scrollMenu.backgroundColor = UIColor.white
        
        //Instantiate and set up buttons for the scroll view
        // Instantiate a mutable array to hold the menu buttons to be created
        var listOfMenuButtons = [UIButton]()
        
        for type in expenseCategories {
            // Instantiate a button to be placed within the horizontally scrollable menu
            let scrollMenuButton = UIButton(type: UIButtonType.custom)
            
            // Obtain the auto manufacturer's logo image
            let categoryIcon = UIImage(named: type)
            
            // Set the button frame at origin at (x, y) = (0, 0) with
            // button width  = auto logo image width + 10 points padding for each side
            // button height = kScrollMenuHeight points
            scrollMenuButton.frame = CGRect(x: 0.0, y: 0.0, width: categoryIcon!.size.width + 20.0, height: kScrollMenuHeight)
            
            // Set the button image to be the expense category icon
            scrollMenuButton.setImage(categoryIcon, for: UIControlState())
            
            // Obtain the title (i.e., auto manufacturer name) to be displayed on the button
            let buttonTitle = type
            
            // The button width and height in points will depend on its font style and size
            let buttonTitleFont = UIFont(name: "Helvetica", size: 14.0)
            
            // Set the font of the button title label text
            scrollMenuButton.titleLabel?.font = buttonTitleFont
            
            // Compute the size of the button title in points
            let buttonTitleSize: CGSize = (buttonTitle as NSString).size(withAttributes: [NSAttributedStringKey.font:buttonTitleFont!])
            
            let titleTextWidth = buttonTitleSize.width
            let logoImageWidth = categoryIcon!.size.width
            
            var buttonWidth: CGFloat = 0.0
            
            // Set the button width to be the largest width + 20 pixels of padding
            if titleTextWidth > logoImageWidth {
                buttonWidth = titleTextWidth + 20.0
            } else {
                buttonWidth = logoImageWidth + 20.0
            }
            
            // Set the button frame with width=buttonWidth height=kScrollMenuHeight points with origin at (x, y) = (0, 0)
            scrollMenuButton.frame = CGRect(x: 0.0, y: 0.0, width: buttonWidth, height: kScrollMenuHeight)
            
            // Set the button title to the automobile manufacturer's name
            scrollMenuButton.setTitle(type, for: UIControlState())
            
            // Set the button title color to black when the button is not selected
            scrollMenuButton.setTitleColor(UIColor.black, for: UIControlState())
            
            // Set the button title color to red when the button is selected
            scrollMenuButton.setTitleColor(UIColor.blue, for: UIControlState.selected)
            
            // Specify the Inset values for top, left, bottom, and right edges for the title
            scrollMenuButton.titleEdgeInsets = UIEdgeInsetsMake(0.0, -categoryIcon!.size.width, -(categoryIcon!.size.height + 5), 0.0)
            
            // Specify the Inset values for top, left, bottom, and right edges for the auto logo image
            scrollMenuButton.imageEdgeInsets = UIEdgeInsetsMake(-(buttonTitleSize.height + 5), 0.0, 0.0, -buttonTitleSize.width)
            
            // Set the button to invoke the buttonPressed: method when the user taps it
            scrollMenuButton.addTarget(self, action: #selector(ExpenseListViewController.buttonPressed(_:)), for: .touchUpInside)
            
            // Add the constructed button to the list of buttons
            listOfMenuButtons.append(scrollMenuButton)
        }
        
        //Compute the sumOfButtonWidths = sum of the widths of all buttons to be displayed in the menu
        var sumOfButtonWidths: CGFloat = 0.0
        
        for j in 0 ..< listOfMenuButtons.count {
            
            // Obtain the obj ref to the jth button in the listOfMenuButtons array
            let button: UIButton = listOfMenuButtons[j]
            
            // Set the button's frame to buttonRect
            var buttonRect: CGRect = button.frame
            
            // Set the buttonRect's x coordinate value to sumOfButtonWidths
            buttonRect.origin.x = sumOfButtonWidths
            
            // Set the button's frame to the newly specified buttonRect
            button.frame = buttonRect
            
            // Add the button to the horizontally scrollable menu
            scrollMenu.addSubview(button)
            
            // Add the width of the button to the total width
            sumOfButtonWidths += button.frame.size.width
        }
        
        // Horizontally scrollable menu's content width size = the sum of the widths of all of the buttons
        // Horizontally scrollable menu's content height size = kScrollMenuHeight points
        scrollMenu.contentSize = CGSize(width: sumOfButtonWidths, height: kScrollMenuHeight)
        
         //Select and show the default auto maker upon app launch
        leftArrowBlack.isHidden = true // Hide left arrow
        
        // The first auto maker on the list is the default one to display
        let defaultButton: UIButton = listOfMenuButtons[0]
        
        // Indicate that the button is selected
        defaultButton.isSelected = true
        
        previousButton = defaultButton
        selectedExpenseType = expenseCategories[0]
        expensesFromSelectedType = getExpensesForSelectedCategory(category: selectedExpenseType)
        
        // Display the table view object's content for the selected auto maker
        expensesTableView.reloadData()
    }
    
    //Use the given category to filter the expenses
    func getExpensesForSelectedCategory(category: String) -> [String] {
        var exps = [String()]
        exps.remove(at: 0)
        if (category == "All") {
            //Get all of the expenses
            exps = expenseNames
        }
        else {
            //Get expenses based on the type
            for eName in expenseNames {
                //[expenseAmount, expenseCategory, expenseBudgeted]
                let expenseType = (applicationDelegate.dict_ExpenseName_ExpenseData[eName] as! Array<String>)[1]
                if (expenseType == category) {
                    //Put this expense name into expensesForSelectedCategory
                    exps.append(eName)
                }
            }
        }
        return exps
    }
    
    /*
     -----------------------------------
     MARK: - Method to Handle Button Tap
     -----------------------------------
     */
    // This method is invoked when the user taps a button in the horizontally scrollable menu
    @objc func buttonPressed(_ sender: UIButton) {

        let selectedButton: UIButton = sender
        selectedButton.isSelected = true // Indicate that the button is selected
        
        if previousButton != selectedButton {
            // Selecting the selected button again should not change its title color
            previousButton.isSelected = false
        }
        
        previousButton = selectedButton
        selectedExpenseType = selectedButton.title(for: UIControlState())!
        expensesFromSelectedType = getExpensesForSelectedCategory(category: selectedExpenseType)
        
        // Redisplay the table view object's content for the selected auto maker
        expensesTableView.reloadData()
    }
    
    /*
     -----------------------------------
     MARK: - Scroll View Delegate Method
     -----------------------------------
     */
    
    // Tells the delegate when the user scrolls the content view within the receiver
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // The autoTableView object scrolling also invokes this method, in the case of which no action
        // should be taken since this method is created to handle only the scrollMenu object's scrolling.
        if scrollView == expensesTableView {
            return
        }
        
        if scrollView.contentOffset.x <= 5 {
            // Scrolling is done all the way to the RIGHT
            leftArrowBlack.isHidden   = true      // Hide left arrow
            rightArrowBlack.isHidden  = false     // Show right arrow
        }
        else if scrollView.contentOffset.x >= (scrollView.contentSize.width - scrollView.frame.size.width) - 5 {
            // Scrolling is done all the way to the LEFT
            leftArrowBlack.isHidden   = false     // Show left arrow
            rightArrowBlack.isHidden  = true      // Hide right arrow
        }
        else {
            // Scrolling is in between. Scrolling can be done in either direction.
            leftArrowBlack.isHidden   = false     // Show left arrow
            rightArrowBlack.isHidden  = false     // Show right arrow
        }
    }
    
    /*
     --------------------------------------
     MARK: - Table View Data Source Methods
     --------------------------------------
     */
    
    // Asks the data source to return the number of rows in a section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expensesFromSelectedType.count
    }
    
    // Asks the data source to return a cell to insert in a particular table view location
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Identify the row number
        let rowNumber = (indexPath as NSIndexPath).row
        
        // Obtain the object reference of a reusable table view cell object instantiated under the identifier
        let cell: ExpenseListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell") as! ExpenseListTableViewCell!
        
        //Set cell attributes
        let expenseDict = applicationDelegate.dict_ExpenseName_ExpenseData as! Dictionary<String, Array<Any>>
        let expenseData = expenseDict[expensesFromSelectedType[rowNumber]]
        cell.expenseNameLabel.text! = expensesFromSelectedType[rowNumber]
        cell.expenseAmountLabel.text! = expenseData![0] as! String
        
        return cell
    }
    
    /*
     ----------------------------------
     MARK: - Table View Delegate Method
     ----------------------------------
     */
    
    // This method is invoked when the user taps a table view row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Identify the row number
        let rowNumber = (indexPath as NSIndexPath).row
        
        // Convert the array to be a Swift array
        let selectedExpense = expensesFromSelectedType[rowNumber]
        
        //Get the rest of the data from the selected expense
        let dict = applicationDelegate.dict_ExpenseName_ExpenseData as! Dictionary<String, Array<String>>
        var expenseArray = dict[selectedExpense]
        expenseArray!.append(selectedExpense)
        
        expenseToBePassed = expenseArray!
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "Expense Info", sender: self)
    }
    
    //Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "Expense Info" {
            
            // Obtain the object reference of the destination view controller
            let expenseInfoViewController: ExpenseInfoViewController = segue.destination as! ExpenseInfoViewController
            
            // Pass the data object to the downstream view controller object
            expenseInfoViewController.expensePassed = expenseToBePassed
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
