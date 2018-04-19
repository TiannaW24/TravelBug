//
//  FirstTranslationViewController.swift
//  TravelBug
//
//  Created by Tyler Trainor on 4/4/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class FirstTranslationViewController: UIViewController {

    //Image View Text Fields
    @IBOutlet var busImageView: UIImageView!
    @IBOutlet var foodImageView: UIImageView!
    @IBOutlet var trainImageView: UIImageView!
    @IBOutlet var policeImageView: UIImageView!
    @IBOutlet var moneyImageView: UIImageView!
    @IBOutlet var doctorImageView: UIImageView!
    
    //Output Variables
    @IBOutlet var phraseOneTranslation: UILabel!
    @IBOutlet var phraseTwoTranslation: UILabel!
    @IBOutlet var phraseThreeTranslation: UILabel!
    
    //Phrase Labels
    @IBOutlet var phraseOneLabel: UILabel!
    @IBOutlet var phraseTwoLabel: UILabel!
    @IBOutlet var phraseThreeLabel: UILabel!
    
    //ImageView Array
    var presetButtons: [UIImageView] = []
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //API Key
    let apiKey = "trnsl.1.1.20180418T190140Z.d89b8f4ad4a5d910.32872d8ea1451edc7d7df8e6a7153eab3b872f73"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presetButtons = [busImageView, foodImageView, trainImageView, policeImageView, moneyImageView, doctorImageView]
        
        setupGestureRecognizers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupGestureRecognizers() {
        //initialize tapGestureRecognizers for each puzzlePiece
        for recognizerNumber in 0...5 {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapping(_:)))
            //Assign a name to the geture recognizer dependant on th name of the puzzle piece
            tapGestureRecognizer.name = String(recognizerNumber)
            presetButtons[recognizerNumber].addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    @objc func handleTapping(_ recognizer: UITapGestureRecognizer) {
        let buttonPressed = presetButtons[Int(recognizer.name!)!]
        var key: String = ""
        switch buttonPressed {
        case busImageView:
            key = "Bus"
        case foodImageView:
            key = "Food"
        case trainImageView:
            key = "Train"
        case policeImageView:
            key = "Police"
        case moneyImageView:
            key = "Money"
        case doctorImageView:
            key = "Doctor"
        default:
            key = ""
        }
        let phrases = applicationDelegate.dict_presetSayings_TranslationData[key] as! [String]
        phraseOneLabel.text = phrases[0]
        phraseTwoLabel.text = phrases[1]
        phraseThreeLabel.text = phrases[2]
        
        phraseOneTranslation.text = translateInput(phrases[0])
        phraseTwoTranslation.text = translateInput(phrases[1])
        phraseThreeTranslation.text = translateInput(phrases[2])
    }
    
    func translateInput(_ phrase: String) -> String {
        
        var toTranslate = phrase
        toTranslate = toTranslate.trimmingCharacters(in: .whitespacesAndNewlines)
        toTranslate = toTranslate.replacingOccurrences(of: " ", with: "%20")
        let langAttribute = "en-" + applicationDelegate.outputLanguage!
        let apiURL = "https://translate.yandex.net/api/v1.5/tr.json/translate?lang=" + langAttribute + "&key=" + apiKey + "&text=" + toTranslate
        
        let url = URL(string: apiURL)
        // Declare jsonData as an optional of type Data
        let jsonData: Data?
        
        do {
            
            //Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
            jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
            
        } catch {
            return "Translation Failed"
        }
        
        if let jsonDataFromApiUrl = jsonData {
            
            // The JSON data is successfully obtained from the API
            
            do {
                /*
                 JSONSerialization class is used to convert JSON and Foundation objects (e.g., NSDictionary) into each other.
                 JSONSerialization class method jsonObject returns an NSDictionary object from the given JSON data.
                 */
                let jsonDataDictionary = try JSONSerialization.jsonObject(with: jsonDataFromApiUrl, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                
                let translation = jsonDataDictionary!["text"] as! NSArray
                return translation[0] as! String
                
            } catch let error as NSError {
                
                showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in JSON Data Serialization: \(error.localizedDescription)")
                return "Translation Failed"
            }
            
        } else {
            showAlertMessage(messageHeader: "JSON Data", messageBody: "Unable to obtain the JSON data file!")
        }
        return "Translation Failed"
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
