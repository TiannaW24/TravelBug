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
        
        let initialView: InitialTranslationViewController = InitialTranslationViewController(nibName: "InitialTranslationViewController", bundle: nil)
        self.addChildViewController(initialView)
        self.translationMainScrollView.addSubview(initialView.view)
        initialView.didMove(toParentViewController: self)
        
        let firstView: FirstTranslationViewController = FirstTranslationViewController(nibName: "FirstTranslationViewController", bundle: nil)
        self.addChildViewController(firstView)
        self.translationMainScrollView.addSubview(firstView.view)
        firstView.didMove(toParentViewController: self)
        
        var v1Frame : CGRect = firstView.view.frame
        v1Frame.origin.x = self.view.frame.width
        firstView.view.frame = v1Frame
        
        let secondView: SecondTranslationViewController = SecondTranslationViewController(nibName: "SecondTranslationViewController", bundle: nil)
        self.addChildViewController(secondView)
        self.translationMainScrollView.addSubview(secondView.view)
        secondView.didMove(toParentViewController: self)
        
        var v2Frame : CGRect = secondView.view.frame
        v2Frame.origin.x = self.view.frame.width * 2
        secondView.view.frame = v2Frame
        
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
