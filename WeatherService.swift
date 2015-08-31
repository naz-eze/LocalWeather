//
//  WeatherService.swift
//  Local Temperature
//
//  Created by Naz on 29/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import Foundation

class WeatherService: NSObject {
    
    var parent: AnyObject?
    
    internal func getWeatherDetails(userLongitude: String, userLatitude: String) -> Void {
        var weatherServiceApi = "http://api.openweathermap.org/data/2.5/weather?lat=\(userLatitude)&lon=\(userLongitude)"
        var urlRequest = NSURLRequest (URL: NSURL(string: weatherServiceApi)!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue(), completionHandler: {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            
            var jsonError:NSError?
            if let connError = error {
                NSLog("[WeatherService] Error connecting to weather service API - \(error.description)")
                return
            }
            
            var result = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? NSDictionary
            if let anyJsonError = jsonError {
                NSLog("[WeatherService] Error parsing JSON - \(anyJsonError.description)")
                return
            } else {
                self.setWeatherValues(result!)
            }
        })
    }
    
    private func setWeatherValues(weatherValues: NSDictionary) -> Void {
        var sys = weatherValues["sys"] as! NSDictionary
        var main = weatherValues["main"] as! NSDictionary
        var weather = weatherValues["weather"] as! NSArray
        var wind = weatherValues["wind"] as! NSDictionary
        
        var city =  weatherValues["name"] as! String
        var country = sys["country"] as! String
        
        var weatherDetails = WeatherDetails(
            location: "\(city), \(country)",
            averageTemperature: main["temp"] as! Double,
            forecast: (weather[0].valueForKey("main") as! String) + " - " + (weather[0].valueForKey("description") as! String),
            humidity:  main["humidity"] as! Double,
            windspeed: wind["speed"] as! Double,
            windDirection: wind["deg"] as! Double,
            weatherIcon: weather[0].valueForKey("icon") as! String,
            sunrise: humanTimeFromUnixTime(sys["sunrise"] as! Double, format: "HH:MM"),
            sunset: humanTimeFromUnixTime(sys["sunset"] as! Double, format: "HH:MM"),
            lastUpdated: humanTimeFromUnixTime(weatherValues["dt"] as! Double, format: "dd-MMM-YYYY, hh:mm")
        )
        weatherDetails.logDetails()
        self.callParent(weatherDetails)
    }
    
    func humanTimeFromUnixTime(value: Double, format: String) -> String {
        var date = NSDate(timeIntervalSince1970: value)
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone()
        return dateFormatter.stringFromDate(date)
    }
    
    private func callParent(weatherDetails: WeatherDetails) -> Void { //TODO: Refactor to event trigger
        if parent is ViewController {
            var vcParent = parent as! ViewController
            vcParent.didGetWeatherDetails(weatherDetails)
        }
        
    }
    
}