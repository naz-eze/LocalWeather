//
//  WeatherValue.swift
//  Local Temperature
//
//  Created by Naz on 30/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import Foundation

extension Double {
    var kelvin: Double {
        return self
    }
    var celcius: Double {
        return self - 272.15
    }
    var fahrenheit: Double {
        return (self - 273.15)*1.8000 + 32.00
    }
}


struct WeatherDetails {
    
    var location: String
    var averageTemperature: Double
    var forecast: String
    
    var humidity: Double
    var windspeed: Double
    var windDirection: Double
    
    var weatherIcon: String
    
    var sunrise: String
    var sunset: String
    
    var lastUpdated: String
    
    func logDetails() {
         NSLog("[WeatherDetails] Weather values = location: \(location). averageTemperature: \(averageTemperature)K."
                + " forecast: \(forecast). humidity: \(humidity). weatherIcon: \(weatherIcon)."
                + " windspeed: \(windspeed). windDirection: \(windDirection). sunrise: \(sunrise)."
                + " sunset: \(sunset). lastUpdated: \(lastUpdated)")
    }
}
