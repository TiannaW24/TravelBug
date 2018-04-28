//
//  GalleryViewController.swift
//  TravelBug
//
//  Created by Woodson, Tianna A (CTR) on 4/27/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //UI Elements
    @IBOutlet var collectionView: UICollectionView!
    
    //Instance Variables
    var imageNames = [String]()
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Background
        let bgImage = UIImage(named: "blue_purple_background")
        let bgImageView = UIImageView()
        bgImageView.frame = self.view.frame
        bgImageView.image = bgImage
        bgImageView.alpha = 0.5
        collectionView.backgroundView = bgImageView
        
        //Get the list of imageNames from the dictionary in the application delegate
        imageNames = applicationDelegate.dict_imageName_Image.allKeys as! [String]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        
        //Create a photoCell whose elements we will be setting
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo Cell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.photoImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        //Retrieve the image from the document directory
        let image = getImage(imageName: imageNames[row])
        
        //Set the cell elements
        cell.photoImageView.image = image
        cell.locationLabel.text = imageNames[row]
        
        return cell
    }
    
    func getImage(imageName: String) -> UIImage{
        var image = UIImage()

        //Create a file manager
        let fileManager = FileManager.default
        //Create the path to the image
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //Try to retrieve the file from the DD, if not, print an error message
        if fileManager.fileExists(atPath: imagePath){
            image = UIImage(contentsOfFile: imagePath)!
        }
        else{
            print("No image was found with the name \(imageName)!")
        }
        
        /*
        let defaults = UserDefaults.standard
        let decoded  = defaults.object(forKey: "Photos") as! Data
        let decodedDict = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Dictionary<String, UIImage>
        image = decodedDict[imageName]!
        */
        
        return image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
