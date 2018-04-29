//
//  TranslationCenterViewController.swift
//  TravelBug
//
//  Created by Tyler Trainor on 4/4/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class TranslationCenterViewController: UIViewController {

    @IBOutlet var translationMainScrollView: UIScrollView!
    
    var primaryLang: String = ""
    var newLang: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize the initial View Controller
        let initialView: InitialTranslationViewController = InitialTranslationViewController(nibName: "InitialTranslationViewController", bundle: nil)
        self.addChildViewController(initialView)
        self.translationMainScrollView.addSubview(initialView.view)
        initialView.didMove(toParentViewController: self)
        
        //initialize the first View Controller
        let firstView: FirstTranslationViewController = FirstTranslationViewController(nibName: "FirstTranslationViewController", bundle: nil)
        self.addChildViewController(firstView)
        self.translationMainScrollView.addSubview(firstView.view)
        firstView.didMove(toParentViewController: self)
        
        //Create a frame for the first view controller
        var v1Frame : CGRect = firstView.view.frame
        //Set x to be one view to the right
        v1Frame.origin.x = self.view.frame.width
        firstView.view.frame = v1Frame
        
        //iniitliaze a second View controller
        let secondView: SecondTranslationViewController = SecondTranslationViewController(nibName: "SecondTranslationViewController", bundle: nil)
        self.addChildViewController(secondView)
        self.translationMainScrollView.addSubview(secondView.view)
        secondView.didMove(toParentViewController: self)
        
        //Create a frame for the second view controller
        var v2Frame : CGRect = secondView.view.frame
        //Set the x value to be two views to the right
        v2Frame.origin.x = self.view.frame.width * 2
        secondView.view.frame = v2Frame
        
        //Set scroll view to the proper width which is three views wide
        self.translationMainScrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.translationMainScrollView.contentSize = CGSize(width: translationMainScrollView.contentSize.width, height: translationMainScrollView.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
