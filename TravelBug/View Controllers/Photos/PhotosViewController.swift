//
//  PhotosViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 4/27/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet var photosScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cameraView: CameraViewController = CameraViewController(nibName: "CameraViewController", bundle: nil)
        self.addChildViewController(cameraView)
        self.photosScrollView.addSubview(cameraView.view)
        cameraView.didMove(toParentViewController: self)
        
        //There will be three views
        self.photosScrollView.contentSize = CGSize(width: self.view.frame.size.width * 3, height: self.view.frame.size.height)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.photosScrollView.contentSize = CGSize(width: photosScrollView.contentSize.width, height: photosScrollView.frame.size.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
