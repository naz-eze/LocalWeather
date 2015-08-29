//
//  WeatherService.swift
//  Local Temperature
//
//  Created by Naz on 29/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import Foundation

class WeatherService: NSObject {
        
    internal func getWeatherDetails(userLongitude: String, userLatitude: String) {
        
        var weatherServiceApi = "http://api.openweathermap.org/data/2.5/weather?lat=\(userLatitude)&lon=\(userLongitude)"
        var urlRequest = NSURLRequest (URL: NSURL(string: weatherServiceApi)!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue(), completionHandler: {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var jsonError:NSError?
            if let connError = error {
                NSLog("Error connecting to weather service API - \(error.description)")
                return
            }
            
            var result = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? NSDictionary
            if let anyJsonError = jsonError {
                NSLog("Error parsing JSON - \(anyJsonError.description)")
                return
            } else {
                self.setWeatherValues(result!)
            }
            
        })
    }
    
    internal func setWeatherValues(weatherValues: NSDictionary) {
       var city =  weatherValues["name"] as String
        // TODO: Get all required values from parsed JSON
    }
    
}
