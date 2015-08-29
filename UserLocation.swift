//
//  UserLocation.swift
//  Local Temperature
//
//  Created by Naz on 27/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import Foundation
import CoreLocation

class UserLocation: NSObject, CLLocationManagerDelegate {
    
    lazy var locationManager = CLLocationManager()
    
    var parent: AnyObject?
    private var longitude: String?
    private var latitude: String?
    
    func getLocationDetails() -> Void {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("Could not update user's location - " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation: CLLocationCoordinate2D = manager.location.coordinate
        
        longitude = userLocation.longitude.description
        latitude = userLocation.latitude.description
        locationManager.stopUpdatingLocation()
        NSLog("User's coordinates - lat:\(latitude!), lon:\(longitude!)")
        self.callParent()
    }

    private func callParent() -> Void {
        if parent is ViewController {
            var vcParent = parent as! ViewController
            vcParent.foundUserLocation(longitude!, latitude: latitude!)
        }
        
    }
    
}