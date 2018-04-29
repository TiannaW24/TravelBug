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
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func savePhotoToTBButtonTapped(_ sender: UIButton) {
        if previewImageView.image == nil {
            showAlertMessage(messageHeader: "No Picture!", messageBody: "Theres no picture to save! Use the Take a Photo button to take a picture.")
            return
        }
        
        let image = previewImageView.image
        let name = "user-photo-\(applicationDelegate.dict_imageName_Image.count)"
        
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
        previewImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        /*
        //Getting the location of the image
        //Get the PHAsset from the photo int the imagePickerController delegate method
        let photoTaken = info[UIImagePickerControllerPHAsset] as? PHAsset
        
        //The field ".location" in the PHAsset contains the location where the photo was taken.
        //Other possible useful fields are .creationDate and .modificationDate to display the date when the photo was taken
        let photoLocation = photoTaken?.location
        
        //Convert the CLLocation obtained from the PHAsset to coordinates
        let photoCoords = photoLocation?.coordinate
        let photoLat = photoCoords?.latitude
        let photoLong = photoCoords?.longitude
        
        //Convert the CLLocation obtained from PHAsset to a city name (Possibly more useful in this context)
        let geoCoder = CLGeocoder()
        
        //Set a variable to store  the postalAdress
        var postalAddress: CNPostalAddress!
        
        //Use the reverseGeocodeLocation method with your CLLocation to obtain the postalAdress
        geoCoder.reverseGeocodeLocation(photoLocation!) { placemarks, error in
            if let e = error {
                print(e)
            } else {
                //Create a placemark with from the CLLocation
                let placeArray = placemarks
                var placeMark: CLPlacemark!
                placeMark = placeArray?[0]
                
                //Get the postalAddress from a field in the placeMark
                postalAddress = placeMark.postalAddress!
                print("NoError")
            }
        }
        
        //Prints out some address information
        print(postalAddress.city)
        print(postalAddress.country)
        print(postalAddress.state)
        */
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
