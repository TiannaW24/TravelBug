//
//  TestViewController.swift
//  TravelBug
//
//  Created by CS3714 on 4/28/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



//Add these import statements
/*
 import Photos
 import MapKit
 import Foundation
 import Contacts
 */


//Paste this code into the delegate method under "previewImageView.image = ...": func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
//When you take a photo (and the delegate method is called), it should print out the city, country, and state where the photo was taken to the Console Window.
/*
 
 
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
