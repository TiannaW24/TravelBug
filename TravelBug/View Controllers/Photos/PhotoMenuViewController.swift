//
//  PhotoMenuViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 4/27/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit
import Photos
import MapKit
import Foundation
import Contacts

class PhotoMenuViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //UI Elements
    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var takeAPhotoButton: UIButton!
    @IBOutlet var savePhotoToTBButton: UIButton!
    @IBOutlet var savePhotoToDeviceButton: UIButton!
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
        takeAPhotoButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        takeAPhotoButton.tintColor = UIColor.white
        savePhotoToTBButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        savePhotoToTBButton.tintColor = UIColor.white
        savePhotoToDeviceButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        savePhotoToDeviceButton.tintColor = UIColor.white
        galleryButton.titleLabel?.font = UIFont (name: "HelveticaNeue-Italic", size: 20)
        galleryButton.tintColor = UIColor.white
        
        previewImageView.contentMode = UIViewContentMode.scaleAspectFit
    }

    @IBAction func takeAPhotoButtonTapped(_ sender: UIButton) {
        //Creation of a camera controller
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        //Present the camera to the user
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func savePhotoToTBButtonTapped(_ sender: UIButton) {
        if previewImageView.image == nil {
            showAlertMessage(messageHeader: "No Picture!", messageBody: "Theres no picture to save! Use the Take a Photo button to take a picture.")
            return
        }
        
        let image = previewImageView.image
        let name = "user-photo-\(applicationDelegate.dict_imageName_Image.count)"
        
        //Save to dictionary
        applicationDelegate.dict_imageName_Image.setObject(image as Any, forKey: name as NSCopying)
        saveImage(imageName: name)
        
        showAlertMessage(messageHeader: "Photo Saved!", messageBody: "Your photo has been saved! You can view it in the Gallery.")
    }
    
    
    @IBAction func savePhotoToDeviceButtonTapped(_ sender: UIButton) {
        if previewImageView.image == nil {
            showAlertMessage(messageHeader: "No Picture!", messageBody: "Theres no picture to save! Use the Take a Photo button to take a picture.")
            return
        }
        let image = previewImageView.image
        
        //Saving to camera roll
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        showAlertMessage(messageHeader: "Photo Saved!", messageBody: "Your photo was saved to your device's Photo Library.")
        
        previewImageView.image = nil
    }
    
    @IBAction func galleryButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Show Gallery", sender: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        //Get the image the user has chosen
        previewImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func saveImage(imageName: String){
        //Create a file manager
        let fileManager = FileManager.default
        //Build the path for the image
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        let image = previewImageView.image!
        //Create a data object for the image
        let data = UIImageJPEGRepresentation(image, 0.5)
        //Store the data at the created path
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
