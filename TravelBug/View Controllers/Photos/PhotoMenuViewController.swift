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
        previewImageView.contentMode = UIViewContentMode.scaleAspectFit
        // Do any additional setup after loading the view.
    }

    @IBAction func takeAPhotoButtonTapped(_ sender: UIButton) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func savePhotoButton(_ sender: UIButton) {
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
        print(imageName)
        let image = previewImageView.image!
        let data = UIImagePNGRepresentation(image)
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
