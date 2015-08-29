//
//  UserLocation.swift
//  Local Temperature
//
//  Created by Naz on 27/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class UserLocation: NSObject, CLLocationManagerDelegate {
    
    lazy var locationManager = CLLocationManager()
    
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
        
        let longitude = userLocation.longitude.description
        let latitude = userLocation.latitude.description
        locationManager.stopUpdatingLocation()
    }

}