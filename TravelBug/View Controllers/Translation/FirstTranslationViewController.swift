//
//  FirstTranslationViewController.swift
//  TravelBug
//
//  Created by Tyler Trainor on 4/4/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit
import AVFoundation

class FirstTranslationViewController: UIViewController {

    //Speech To Text
    let speechSynthesizer = AVSpeechSynthesizer()
    
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
    
    //Phrase Speaker Buttons
    @IBOutlet var phraseOneSpeakerButton: UIButton!
    @IBOutlet var phraseTwoSpeakerButton: UIButton!
    @IBOutlet var phraseThreeSpeakerButton: UIButton!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var scrollView: UIScrollView!
    
    //ImageView Array
    var presetButtons: [UIImageView] = []
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //API Key
    let apiKey = "trnsl.1.1.20180418T190140Z.d89b8f4ad4a5d910.32872d8ea1451edc7d7df8e6a7153eab3b872f73"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Tab Bar
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        
        //Background
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
        
        //Welcome and instruction label
        phraseOneLabel.font = UIFont (name: "HelveticaNeue-BoldItalic", size: 16)
        phraseOneLabel.textColor = UIColor.black
        phraseTwoLabel.font = UIFont (name: "HelveticaNeue-BoldItalic", size: 16)
        phraseTwoLabel.textColor = UIColor.black
        phraseThreeLabel.font = UIFont (name: "HelveticaNeue-BoldItalic", size: 16)
        phraseThreeLabel.textColor = UIColor.black
        phraseOneTranslation.font = UIFont (name: "HelveticaNeue-Italic", size: 16)
        phraseOneTranslation.textColor = UIColor.black
        phraseTwoTranslation.font = UIFont (name: "HelveticaNeue-Italic", size: 16)
        phraseTwoTranslation.textColor = UIColor.black
        phraseThreeTranslation.font = UIFont (name: "HelveticaNeue-Italic", size: 16)
        phraseThreeTranslation.textColor = UIColor.black
        
        //Buttons
        let tempImgOne = phraseOneSpeakerButton.imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        phraseOneSpeakerButton.imageView?.image = tempImgOne
        phraseOneSpeakerButton.tintColor = UIColor.white
        let tempImgTwo = phraseTwoSpeakerButton.imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        phraseTwoSpeakerButton.imageView?.image = tempImgTwo
        phraseTwoSpeakerButton.tintColor = UIColor.white
        let tempImgThree = phraseThreeSpeakerButton.imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        phraseThreeSpeakerButton.imageView?.image = tempImgThree
        phraseThreeSpeakerButton.tintColor = UIColor.white
        
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
    
    //SPEAKER BUTTONS TAPPED
    
    @IBAction func translationOneSpeakerButtonTapped(_ sender: UIButton) {
        pronounceText(text: phraseOneTranslation.text!)
    }
    
    
    @IBAction func translationTwoSpeakerButtonTapped(_ sender: UIButton) {
        pronounceText(text: phraseTwoTranslation.text!)
    }
    
    
    @IBAction func translationThreeSpeakerButtonTapped(_ sender: UIButton) {
        pronounceText(text: phraseThreeTranslation.text!)
    }
    
    func pronounceText(text: String) {
        let whatToSay = AVSpeechUtterance(string: text)
        whatToSay.voice = AVSpeechSynthesisVoice(language: applicationDelegate.outputLanguage)
        
        speechSynthesizer.speak(whatToSay)
    }
    
    //Yandex Link Pressed
    @IBAction func yandexPressed(_ sender: UIButton) {
        if let url = URL(string: "https://translate.yandex.com/") {
            UIApplication.shared.open(url, options: [:])
        }
        
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
