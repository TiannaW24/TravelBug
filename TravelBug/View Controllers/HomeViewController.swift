//
//  HomeViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 4/18/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLabel.font = UIFont (name: "HelveticaNeue-LightItalic", size: 50)
        welcomeLabel.textColor = UIColor.white
        
        self.tabBarController?.tabBar.barTintColor = UIColor.black

        let bgImage = UIImage(named: "blue_purple_background")
        let bgImageView = UIImageView()
        bgImageView.frame = self.view.frame
        bgImageView.image = bgImage
        bgImageView.alpha = 0.5
        self.view.addSubview(bgImageView)
        self.view.sendSubview(toBack: bgImageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
