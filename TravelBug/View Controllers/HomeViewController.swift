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
    @IBOutlet var insLabel: UILabel!
    @IBOutlet var globeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Welcome and instruction label
        welcomeLabel.font = UIFont (name: "HelveticaNeue-LightItalic", size: 50)
        welcomeLabel.textColor = UIColor.white
        insLabel.font = UIFont (name: "HelveticaNeue-LightItalic", size: 30)
        insLabel.textColor = UIColor.white
        
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
        
        //Gif
        let globeGif = UIImage.gifImageWithName("globeanimation")
        globeImageView.image = globeGif
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
