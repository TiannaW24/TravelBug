//
//  DirectionsMapViewController.swift
//  TravelBug
//
//  Created by CS3714 on 4/15/18.
//  Copyright © 2018 Tianna Woodson. All rights reserved.
//

//
//  GeocodingMapViewController.swift
//  VTQuest
//
//  Created by Osman Balci on 10/20/17.
//  Copyright © 2017 Osman Balci. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DirectionsMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    
    // Instance variable holding the object reference of the MKMapView object created in the Storyboard
    @IBOutlet var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    
    // Data set by upstream view controller GeocodingViewController
    var addressPassed = ""
    var mapTypePassed: MKMapType?
    var latitudePassed: Double?
    var longitudePassed: Double?
    var directionTypePassed = ""
    
    // The amount of north-to-south distance (measured in meters) to use for the span.
    let latitudinalSpanInMeters: Double = 804.672    // = 0.5 mile
    
    // The amount of east-to-west distance (measured in meters) to use for the span.
    let longitudinalSpanInMeters: Double = 804.672   // = 0.5 mile
    
    /*
     -----------------------
     MARK: - View Life Cycle
     -----------------------
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //--------------------------------------------------
        // Adjust the title to fit within the navigation bar
        //--------------------------------------------------
        
        let navigationBarWidth = self.navigationController?.navigationBar.frame.width
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height
        let labelRect = CGRect(x: 0, y: 0, width: navigationBarWidth!, height: navigationBarHeight!)
        let titleLabel = UILabel(frame: labelRect)
        
        titleLabel.text = addressPassed
        
        titleLabel.font = titleLabel.font.withSize(12)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        self.navigationItem.titleView = titleLabel
        
        //-----------------------------
        // Dress up the map view object
        //-----------------------------
        
        //mapView.mapType = mapTypePassed!
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = false
        mapView.delegate = self
        mapView.showsScale = true
        mapView.showsPointsOfInterest = true
        mapView.showsUserLocation = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        let sourceCoordinates = locationManager.location?.coordinate
        let destCoordinates = CLLocationCoordinate2DMake(latitudePassed!, longitudePassed!)
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates!)
        let destPlacemark = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destItem = MKMapItem(placemark: destPlacemark)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        if (directionTypePassed == "Walking") {
            directionRequest.transportType = .walking
        } else {
            directionRequest.transportType = .automobile
        }
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: { (response, error) in
            
            guard let response = response else {
                if let error = error {
                    print("Something went wrong when getting directions")
                }
                return
            }
            
            let route = response.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            
            let rekt = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
            
            
            })
        

        
        
        
        
        // Address Center Geolocation
        let addressCenterLocation = CLLocationCoordinate2D(latitude: latitudePassed!, longitude: longitudePassed!)
        
        // Define map's visible region
        //let addressMapRegion: MKCoordinateRegion? = MKCoordinateRegionMakeWithDistance(addressCenterLocation, latitudinalSpanInMeters, longitudinalSpanInMeters)
        
        // Set the mapView to show the defined visible region
       // mapView.setRegion(addressMapRegion!, animated: true)
        
        //*************************************
        // Prepare and Set Address Annotation
        //*************************************
        
        // Instantiate an object from the MKPointAnnotation() class and place its obj ref into local variable annotation
        let annotation = MKPointAnnotation()
        
        // Dress up the newly created MKPointAnnotation() object
        annotation.coordinate = addressCenterLocation
        annotation.title = addressPassed
        annotation.subtitle = ""
        
        // Add the created and dressed up MKPointAnnotation() object to the map view
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    //User tapped the Get Directions In Maps Button
    @IBAction func getDirectionsButtonTapped(_ sender: UIButton) {
        let latitude:CLLocationDegrees = latitudePassed!
        let longitude:CLLocationDegrees = longitudePassed!
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(addressPassed)"
        mapItem.openInMaps(launchOptions: options)

    }
    
    
    
}

