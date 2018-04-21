//
//  CurrencyConverterViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 3/21/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var convertButton: UIButton!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var conversionResultLabel: UILabel!
    @IBOutlet var fromCurrencyTextField: UITextField!
    @IBOutlet var toCurrencyTextField: UITextField!
    @IBOutlet var toCurrencyLabel: UILabel!
    @IBOutlet var fromCurrencyLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var seeCurrenciesButton: UIButton!
    
    //Instance variables
    var countries = [String()] //Holds names of all currencies
    var pickerData: [String] = [String]() //Holder for categoryPicker options
    
    override func viewDidLoad() {
        super.viewDidLoad()
        conversionResultLabel.text! = ""
        
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
        
        //TextFields
        toCurrencyTextField.alpha = 0.7
        fromCurrencyTextField.alpha = 0.7
        amountTextField.alpha = 0.7
        
        //Labels and buttons
        toCurrencyLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        fromCurrencyLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        amountLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        conversionResultLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        convertButton.tintColor = UIColor.white
        seeCurrenciesButton.tintColor = UIColor.white
        
        //------------LOAD CURRENCIES FROM API----------------
        // Define the API query URL to obtain company data for a given stock symbol
        let apiUrl = "https://free.currencyconverterapi.com/api/v5/countries"
        
        // Create a URL struct data structure from the API query URL string
        let url = URL(string: apiUrl)
        
        // Declare jsonData as an optional of type Data
        let jsonData: Data?
        
        do {
            /*
             Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
             Option mappedIfSafe indicates that the file should be mapped into virtual memory, if possible and safe.
             */
            jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
            
        } catch {
            showAlertMessage(messageHeader: "API Error!", messageBody: "There was an error reading the JSON response from the API call!")
            return
        }
        
        if let jsonDataFromApiUrl = jsonData {
            
            // The JSON data is successfully obtained from the API
            
            do {
                /*
                 JSONSerialization class is used to convert JSON and Foundation objects (e.g., NSDictionary) into each other.
                 JSONSerialization class method jsonObject returns an NSDictionary object from the given JSON data.
                 */
                let jsonDataDictionary = try JSONSerialization.jsonObject(with: jsonDataFromApiUrl, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                
                // Typecast the returned NSDictionary as Dictionary<String, AnyObject>
                let dictionaryOfCurrencies = jsonDataDictionary as! Dictionary<String, AnyObject>
                
                
                /*
                 Extract all of the data items of interest from the JSON data
                 */
                
                //Use the array of dictionaries to populate the newsData array
                let results = (dictionaryOfCurrencies["results"] as! Dictionary<String, Any>) as Dictionary<String, Any>
                
                for result in results {
                    
                    let resultDict = result.value as! Dictionary<String, String>
                    
                    //Variables to set
                    let countryName = resultDict["name"]
                    let countryID = resultDict["id"]
                    let currencyName = resultDict["currencyName"]
                    let currencyID = resultDict["currencyId"]
                    
                    //Put everything into one array
                    let currencyData = [countryID, currencyName, currencyID]
                    
                    /*
                     Add the created array under the company name Key to the dictionary
                     dict_CurrencyID_CurrencyData held by the app delegate object.
                     */
                    applicationDelegate.dict_CountryName_CountryData.setObject(currencyData, forKey: countryName! as NSCopying)
                }
                
                countries = applicationDelegate.dict_CountryName_CountryData.allKeys as! [String]

            }
            catch {
                showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in JSON Data Serialization: \(error.localizedDescription)")
                return
            }
        }
        else {
            showAlertMessage(messageHeader: "JSON Data", messageBody: "Unable to obtain the JSON data file!")
        }
    }
    
    @IBAction func seeAvailableCurrenciesButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "Currencies Table", sender: self)
    }
    
    
    @IBAction func convertButtonPressed(_ sender: UIButton) {
        //Do input validations, if they pass show the conversion
        let toInput = toCurrencyTextField.text!
        let fromInput = fromCurrencyTextField.text!
        
        if (fromInput == "") {
            showAlertMessage(messageHeader: "Currency Symbol Error!", messageBody: "Please enter a currency symbol to convert from")
            return
        }
        if (toInput == "") {
            showAlertMessage(messageHeader: "Currency Symbol Error!", messageBody: "Please enter a currency symbol to convert to")
            return
        }
        if (amountTextField.text! == "") {
            showAlertMessage(messageHeader: "Currency Amount Error!", messageBody: "Please enter a currency amount to convert")
            return
        }
        if (!checkValidCurrencyID(givenCurrencyID: fromInput)) {
            showAlertMessage(messageHeader: "Currency Symbol Error!", messageBody: "Sorry, \(fromInput) is not a recognized currency. Please use the Available Currencies link to view recognized currencies")
            return
        }
        if (!checkValidCurrencyID(givenCurrencyID: toInput)) {
            showAlertMessage(messageHeader: "Currency Symbol Error!", messageBody: "Sorry, \(toInput) is not a recognized currency. Please use the Avaialble Currencies link to view recognized currencies")
            return
        }
        if (Double(amountTextField.text!) == nil) {
            showAlertMessage(messageHeader: "Currency Amount Error!", messageBody: "Sorry, that amount is not convertable. Please try again")
            return
        }
        
        //---------------USE API TO SHOW CONVERSION------------------
        var conversionFactor = 0.00
        var convertedAmount = 0.00
        //API CALL
        let apiUrl = "https://free.currencyconverterapi.com/api/v5/convert?q=\(fromInput)_\(toInput)&compact=ultra"
        let url = URL(string: apiUrl)
        let jsonData: Data?
        
        do {
            jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
            
        } catch {
            showAlertMessage(messageHeader: "API Error!", messageBody: "There was an error reading the JSON response from the API call!")
            return
        }
        
        if let jsonDataFromApiUrl = jsonData {
            do {
                let jsonDataDictionary = try JSONSerialization.jsonObject(with: jsonDataFromApiUrl, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                
                let dictionaryWithCurrency = jsonDataDictionary as! Dictionary<String, AnyObject>
                conversionFactor = dictionaryWithCurrency["\(fromInput)_\(toInput)"] as! Double
            }
            catch {
                showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in JSON Data Serialization: \(error.localizedDescription)")
                return
            }
        }
        else {
            showAlertMessage(messageHeader: "JSON Data", messageBody: "Unable to obtain the JSON data file!")
        }
        
        //Calculate
        let amountDouble = Double(amountTextField.text!)
        convertedAmount = amountDouble! * conversionFactor
        let formattedConvertedAmount = String(format: "%.2f", convertedAmount)
        
        //Update the label
        conversionResultLabel.text = "\(amountTextField.text!) in \(toInput) is \(formattedConvertedAmount) in \(fromInput)"
    }
    
    func checkValidCurrencyID(givenCurrencyID: String) -> Bool {
        var matched = false
        for c in countries {
            let dict = applicationDelegate.dict_CountryName_CountryData
            //[countryID, currencyName, currencyID]
            let currencyID = (dict[c]! as! Array)[2] as String
            if (currencyID == givenCurrencyID) {
                matched = true
            }
        }
        return matched
    }
    
    @IBAction func keyboardDone(_ sender: UITextField) {
        // When the Text Field resigns as first responder, the keyboard is automatically removed.
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTouch(_ sender: UIControl) {
        view.endEditing(true)
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
