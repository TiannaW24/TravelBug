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
    @IBOutlet var toLanguageLabel: UILabel!
    @IBOutlet var fromLanguageLabel: UILabel!
    
    struct languageStruct {
        var key = ""
        var lang = ""
    }
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var primaryLanguage: String = ""
    var outputLanguage: String = ""
    
    var dict_languageKeys_languageData: NSDictionary = NSDictionary()
    var languages = [languageStruct]()
    
    let apiKey = "trnsl.1.1.20180418T190140Z.d89b8f4ad4a5d910.32872d8ea1451edc7d7df8e6a7153eab3b872f73"
    let apiRequest = "https://translate.yandex.net/api/v1.5/tr.json/getLangs?key=trnsl.1.1.20180418T190140Z.d89b8f4ad4a5d910.32872d8ea1451edc7d7df8e6a7153eab3b872f73&ui=en"
    
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
        
        //Get a list of accepted languages from the API
        getLanguages()
        //Setup the Picker Views delegate and data sources to be the view controller
        primaryLangPickerView.delegate = self
        primaryLangPickerView.delegate = self
        outputLanguagePickerView.dataSource = self
        outputLanguagePickerView.delegate = self
        
        //Labels
        toLanguageLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        toLanguageLabel.textColor = UIColor.black
        fromLanguageLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        fromLanguageLabel.textColor = UIColor.black
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row].lang
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            applicationDelegate.primaryLanguage = languages[row].key
        }
        else if pickerView.tag == 1 {
            applicationDelegate.outputLanguage = languages[row].key
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
                let keys = languagesData.allKeys as! [String]
                for key in keys {
                    languages.append(languageStruct(key: key, lang: languagesData[key] as! String))
                }
                languages = languages.sorted {$0.lang < $1.lang}
                
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
