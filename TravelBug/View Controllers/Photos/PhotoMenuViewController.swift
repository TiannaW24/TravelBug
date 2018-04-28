//
//  PhotoMenuViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 4/27/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class PhotoMenuViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //UI Elements
    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var takeAPhotoButton: UIButton!
    @IBOutlet var savePhotoButton: UIButton!
    @IBOutlet var galleryButton: UIButton!
    
    //Instance variables
    var imagePickerController : UIImagePickerController!
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background
        let bgImage = UIImage(named: "blue_purple_background")
        let bgImageView = UIImageView()
        bgImageView.frame = self.view.frame
        bgImageView.image = bgImage
        bgImageView.alpha = 0.5
        self.view.addSubview(bgImageView)
        self.view.sendSubview(toBack: bgImageView)
        
        //Buttons
        takeAPhotoButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        takeAPhotoButton.tintColor = UIColor.white
        savePhotoButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        savePhotoButton.tintColor = UIColor.white
        galleryButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 18)
        galleryButton.tintColor = UIColor.white
        
        previewImageView.contentMode = UIViewContentMode.scaleAspectFit
    }

    @IBAction func takeAPhotoButtonTapped(_ sender: UIButton) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func savePhotoButtonTapped(_ sender: UIButton) {
        if previewImageView.image == nil {
            showAlertMessage(messageHeader: "No Picture!", messageBody: "Theres no picture to save! Use the Take a Photo button to take a picture.")
            return
        }
        
        let image = previewImageView.image
        let name = "user-photo-\(applicationDelegate.dict_imageName_Image.count)"
        saveImage(imageName: name)
        applicationDelegate.dict_imageName_Image.setObject(image as Any, forKey: name as NSCopying)
        
        showAlertMessage(messageHeader: "Photo Saved!", messageBody: "Your photo has been saved! You can view it in the Gallery.")
        previewImageView.image = nil
    }
    
    @IBAction func galleryButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Show Gallery", sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        previewImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func saveImage(imageName: String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        let image = previewImageView.image!
        let data = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
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
