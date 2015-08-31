//
//  ViewController.swift
//  Local Temperature
//
//  Created by Naz on 26/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var forecastLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var buttonRef: UIButton!
    
    lazy var userLocation = UserLocation()
    lazy var weatherService = WeatherService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonProperties()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func runApp(sender: UIButton) {
        userLocation.parent = self
        userLocation.getLocationDetails()
    }
    
    func foundUserLocation(longitude: String, latitude: String) -> Void { //TODO: Refactor to event listener
        weatherService.parent = self
        weatherService.getWeatherDetails(longitude, userLatitude: latitude)
    }
    
    func didGetWeatherDetails(weatherDetails: WeatherDetails) -> Void { //TODO: Refactor to event listener
        dispatch_async(dispatch_get_main_queue()) {
            self.locationLabel.text = weatherDetails.location
            self.temperatureLabel.text = String(stringInterpolationSegment: weatherDetails.averageTemperature)
            self.forecastLabel.text = weatherDetails.forecast
            self.humidityLabel.text = String(stringInterpolationSegment: weatherDetails.humidity) + "%"
            self.windSpeedLabel.text = String(stringInterpolationSegment: weatherDetails.windspeed) + "meter/sec"
            self.sunriseLabel.text = weatherDetails.sunrise
            self.sunsetLabel.text = weatherDetails.sunset
        }
    }
    
    private func setButtonProperties() -> Void {
        buttonRef.layer.cornerRadius = 10;
        buttonRef.layer.borderWidth = 0.75;
        buttonRef.backgroundColor = UIColor.clearColor()
        buttonRef.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

}

