//
//  PhotoDetailViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 4/28/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    //UI Elements
    @IBOutlet var photoImageView: UIImageView!
    
    //Instance variables
    var imageNamePassed = ""
    var image: UIImage!
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image = applicationDelegate.dict_imageName_Image[imageNamePassed] as! UIImage
        photoImageView.contentMode = UIViewContentMode.scaleAspectFit
        photoImageView.image = image
        
        //Gesture Recognizer
        let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(imagePressed(tapGestureRecognizer:)))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imagePressed(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImageView = tapGestureRecognizer.view as! UIImageView
        
        let alert = UIAlertController(title: "Save Photo?", message: "Would you like to save this photo to your device?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            //Saving to camera roll
            UIImageWriteToSavedPhotosAlbum(tappedImageView.image!, nil, nil, nil)
            self.showAlertMessage(messageHeader: "Photo Saved", messageBody: "Your photo was saved to your device!")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
