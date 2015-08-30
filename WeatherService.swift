//
//  WeatherService.swift
//  Local Temperature
//
//  Created by Naz on 29/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import Foundation

class WeatherService: NSObject {
    
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
        var location = "\(city), \(country)"
        
        var avgTemp = main["temp"] as! Double
        var forecast = (weather[0].valueForKey("main") as! String) + ", " + (weather[0].valueForKey("description") as! String)
        
        var humidity = main["humidity"] as! Double
        var windspeed = wind["speed"] as! Double
        var windDirection = wind["deg"] as! Double

        var weatherIcon = weather[0].valueForKey("icon") as! String
        
        var sunrise = humanTimeFromUnixTime(sys["sunrise"] as! Double)
        var sunset = humanTimeFromUnixTime(sys["sunset"] as! Double)
        var lastUpdated = humanTimeFromUnixTime(weatherValues["dt"] as! Double)
        
        
        NSLog("[WeatherService] Weather values = location: \(location). avgTemp: \(avgTemp)K. forecast: \(forecast). humidity - \(humidity)."
                                + " windspeed: \(windspeed). windDirection: \(windDirection). sunrise: \(sunrise)."
                                + " sunset: \(sunset). lastUpdated: \(lastUpdated)")
    }
    
    func humanTimeFromUnixTime(value: Double) -> String {
        var date = NSDate(timeIntervalSince1970: value)
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MMM-YYYY, hh:mm a"
        dateFormatter.timeZone = NSTimeZone()
        return dateFormatter.stringFromDate(date)
    }
    
}