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

        imageNames = applicationDelegate.dict_imageName_Image.allKeys as! [String]
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Photo Cell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.photoImageView.contentMode = UIViewContentMode.scaleAspectFit
        let image = getImage(imageName: imageNames[row])
        cell.photoImageView.image = image
        cell.locationLabel.text = imageNames[row]
        
        return cell
    }
    
    func getImage(imageName: String) -> UIImage{
        var image = UIImage()
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            image = UIImage(contentsOfFile: imagePath)!
        }
        else{
            print("No image was found with the name \(imageName)!")
        }
        return image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
