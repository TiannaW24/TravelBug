//
//  SecondTranslationViewController.swift
//  TravelBug
//
//  Created by Tyler Trainor on 4/4/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class SecondTranslationViewController: UIViewController {

    //Text View Variable
    @IBOutlet var translateFromTextView: UITextView!
    @IBOutlet var translateToTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translateFromTextView.text = InitialTranslationViewController.setLang.primaryLanguage
        translateToTextView.text = InitialTranslationViewController.setLang.translateToo
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
