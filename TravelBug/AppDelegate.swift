//
//  AppDelegate.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 2/27/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//
//
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var dict_CountryName_CountryData: NSMutableDictionary = NSMutableDictionary()
    var dict_ExpenseName_ExpenseData: NSMutableDictionary = NSMutableDictionary()
    
    var dict_presetSayings_TranslationData: NSMutableDictionary = NSMutableDictionary()
    
    var primaryLanguage: String?
    var outputLanguage: String?
    
    var window: UIWindow?
    
    /*
     Read the dictionary as soon as the app starts up
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Get path to Expenses
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        
        // Add the plist filename to the document directory path to obtain an absolute path to the plist filename
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/Expenses.plist"
        let plistFileLanguagesPathInDocumentDirectory = documentDirectoryPath + "View Controllers/Translation Center/presetSayings.plist"
        
        /*
         Instantiate an NSMutableDictionary object and initialize it with the contents of the Expense.plist file.
         ALLOWS MUTABILITY
         */
        let dictionaryFromFile: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInDocumentDirectory)
        let dictionaryFromFileLanguages: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFileLanguagesPathInDocumentDirectory)
        
        //If dictionaryFromFile was successful, we create a dictionary
        if let dictionaryFromFileInDocumentDirectory = dictionaryFromFile {
            
            // Expense.plist exists in the Document directory
            dict_ExpenseName_ExpenseData = dictionaryFromFileInDocumentDirectory
            
        } else {
            
            // Expenses.plist does not exist in the Document directory; Read it from the main bundle.
            // Obtain the file path to the plist file in the mainBundle (project folder)
            let plistFilePathInMainBundle = Bundle.main.path(forResource: "Expenses", ofType: "plist")
            
            // Instantiate an NSMutableDictionary object and initialize it with the contents of the CompaniesILike.plist file.
            let dictionaryFromFileInMainBundle: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInMainBundle!)
            
            // Store the object reference into the instance variable
            dict_ExpenseName_ExpenseData = dictionaryFromFileInMainBundle!
        }
        
        if let languageDictionaryFromFileDirectory = dictionaryFromFileLanguages {
            dict_presetSayings_TranslationData = languageDictionaryFromFileDirectory
        }
        else {
            // presetSayings.plist does not exist in the Document directory; Read it from the main bundle.
            // Obtain the file path to the plist file in the mainBundle (project folder)
            let languagePlistFilePathInMainBundle = Bundle.main.path(forResource: "presetSayings", ofType: "plist")
            
            // Instantiate an NSMutableDictionary object and initialize it with the contents of the CompaniesILike.plist file.
            let languageDictionaryFromFileInMainBundle: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: languagePlistFilePathInMainBundle!)
            
            // Store the object reference into the instance variable
            dict_presetSayings_TranslationData = languageDictionaryFromFileInMainBundle!
        }
        
        // Override point for customization after application launch.
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
        
        // Define the file path to the CompaniesILike.plist file in the Document directory
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        
        // Add the plist filename to the document directory path to obtain an absolute path to the plist filename
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/Expenses.plist"
        
        // Write the NSMutableDictionary to the CompaniesILike.plist file in the Document directory
        dict_ExpenseName_ExpenseData.write(toFile: plistFilePathInDocumentDirectory, atomically: true)
    }
}

