//
//  SecondTranslationViewController.swift
//  TravelBug
//
//  Created by Tyler Trainor on 4/4/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit
import AVFoundation

class SecondTranslationViewController: UIViewController {

    //Text View Variable
    @IBOutlet var translateFromTextView: UITextView!
    @IBOutlet var translateToTextView: UITextView!
    @IBOutlet var translateFromLabel: UILabel!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var pronounciationButton: UIButton!
    
    //Speech To Text
    let speechSynthesizer = AVSpeechSynthesizer()
    
    let apiKey = "trnsl.1.1.20180418T190140Z.d89b8f4ad4a5d910.32872d8ea1451edc7d7df8e6a7153eab3b872f73"
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Tab Bar
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        
        //Background
        let bgImage = UIImage(named: "blue_purple_background")
        let bgImageView = UIImageView()
        bgImageView.frame = CGRect(x: 0, y:0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        bgImageView.image = bgImage
        bgImageView.alpha = 0.5
        self.view.addSubview(bgImageView)
        self.view.sendSubview(toBack: bgImageView)
        
        //Instruction labels and Buttons
        translateFromLabel.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        translateFromLabel.textColor = UIColor.black
        translateButton.tintColor = UIColor.white
        
        //TextViews
        translateToTextView.alpha = 0.7
        translateFromTextView.alpha = 0.7
    
        
        translateFromTextView.text = ""
        translateToTextView.text = ""
        
        let tempImgOne = pronounciationButton.imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        pronounciationButton.imageView?.image = tempImgOne
        pronounciationButton.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func translateInput(_ apiURL: String) -> String {
        
        
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
     ------------------------
     MARK: - IBAction Methods
     ------------------------
     */
    
    @IBAction func translateButtonPressed(_ sender: UIButton) {
        //Lower the keyboard
        translateFromTextView.resignFirstResponder()
        //get text to translate
        var toTranslate = translateFromTextView.text!
        //remove whitespaces properly as done in other views
        toTranslate = toTranslate.trimmingCharacters(in: .whitespacesAndNewlines)
        toTranslate = toTranslate.replacingOccurrences(of: " ", with: "%20")
        //Set the lang attribute for the api query
        let langAttribute = applicationDelegate.primaryLanguage! + "-" + applicationDelegate.outputLanguage!
        //Set api request url
        let apiString = "https://translate.yandex.net/api/v1.5/tr.json/translate?lang=" + langAttribute + "&key=" + apiKey + "&text=" + toTranslate
        //Trasnlate the input and set the text view to display it
        let translation = translateInput(apiString)
        translateToTextView.text = translation
    }
    
    @IBAction func keyboardDone(_ sender: UITextView) {
        
        // When the Text Field resigns as first responder, the keyboard is automatically removed.
        sender.resignFirstResponder()
    }
    
    @IBAction func backgroundTouch(_ sender: UIControl) {
        /*
         "This method looks at the current view and its subview hierarchy for the text field that is
         currently the first responder. If it finds one, it asks that text field to resign as first responder.
         If the force parameter is set to true, the text field is never even asked; it is forced to resign." [Apple]
         
         When the Text Field resigns as first responder, the keyboard is automatically removed.
         */
        view.endEditing(true)
    }
    
    //Yandex Link Pressed Load Yandex Trasnlate in Safari
    @IBAction func yandexPressed(_ sender: UIButton) {
        if let url = URL(string: "https://translate.yandex.com/") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
    
    //Speaker button pressed
    @IBAction func pronounceTransaltion(_ sender: Any) {
        pronounceText(text: translateToTextView.text!)
    }
    
    //Create an AV Speech Utterance for the transalted text and say it
    func pronounceText(text: String) {
        let whatToSay = AVSpeechUtterance(string: text)
        whatToSay.voice = AVSpeechSynthesisVoice(language: applicationDelegate.outputLanguage)

        speechSynthesizer.speak(whatToSay)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
         ---------------------------------------------------------------------
         Force this view to be displayed first in Portrait device orientation.
         However, the user can override this by manually rotating the device.
         ---------------------------------------------------------------------
         */
        let portraitValue = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(portraitValue, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
    }

}
