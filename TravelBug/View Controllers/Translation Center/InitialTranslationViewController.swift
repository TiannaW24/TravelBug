//
//  InitialTranslationViewController.swift
//  TravelBug
//
//  Created by Tyler Trainor on 4/4/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class InitialTranslationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //Picker Views
    @IBOutlet var primaryLangPickerView: UIPickerView!
    
    @IBOutlet var outputLanguagePickerView: UIPickerView!
    
    //Struct to contain language settings
    struct setLang {
        static var primaryLanguage = ""
        static var translateToo = ""
    }
    
    var dict_languageKeys_languageData: NSDictionary = NSDictionary()
    var languages: [String] = []
    
    let apiKey = "trnsl.1.1.20180418T190140Z.d89b8f4ad4a5d910.32872d8ea1451edc7d7df8e6a7153eab3b872f73"
    let apiRequest = "https://translate.yandex.net/api/v1.5/tr.json/getLangs?key=trnsl.1.1.20180418T190140Z.d89b8f4ad4a5d910.32872d8ea1451edc7d7df8e6a7153eab3b872f73&ui=en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get a list of accepted languages from the API
        getLanguages()
        //Setup the Picker Views delegate and data sources to be the view controller
        primaryLangPickerView.delegate = self
        primaryLangPickerView.delegate = self
        outputLanguagePickerView.dataSource = self
        outputLanguagePickerView.delegate = self
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            setLang.primaryLanguage = languages[row]
        }
        else if pickerView.tag == 1 {
            setLang.translateToo = languages[row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLanguages() {
        
        let url = URL(string: apiRequest)
        // Declare jsonData as an optional of type Data
        let jsonData: Data?
        
        do {
            
            //Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
            jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
            
        } catch {
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
                
                let languagesData = jsonDataDictionary!["langs"] as! NSDictionary
                dict_languageKeys_languageData = languagesData
                var keys = languagesData.allKeys as! [String]
                keys = keys.sorted { $0 < $1 }
                for key in keys {
                    languages.append(languagesData[key] as! String)
                }
                
            } catch let error as NSError {
                
                showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in JSON Data Serialization: \(error.localizedDescription)")
                return
            }
            
        } else {
            showAlertMessage(messageHeader: "JSON Data", messageBody: "Unable to obtain the JSON data file!")
        }
        return
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

}
