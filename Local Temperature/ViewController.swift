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
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var forecastIcon: UIImageView!

    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var tempSegmentControl: UISegmentedControl!
    
    lazy var userLocation = UserLocation()
    lazy var weatherService = WeatherService()
    let colours = Colours()
    var weatherDetails: WeatherDetails?
    
    
    @IBAction func tempSegmentChange(sender: UISegmentedControl) {
        if let weatherDet = weatherDetails {
            switch tempSegmentControl.selectedSegmentIndex {
            case 0:
                self.temperatureLabel.text = String(format: "%.0f", weatherDet.averageTemperature.celcius)
            case 1:
                self.temperatureLabel.text = String(format: "%.0f", weatherDet.averageTemperature.fahrenheit)
            case 2:
                self.temperatureLabel.text = String(format: "%.0f", weatherDet.averageTemperature.kelvin)
            default:
                break
            }
        }
    }
    
    @IBAction func reload(sender: UIButton) {
        self.loading.startAnimating()
        userLocation.parent = self
        userLocation.getLocationDetails()
    }
    
    func refresh() {
        view.backgroundColor = UIColor.clearColor()
        var backgroundLayer = colours.gl
        backgroundLayer.frame = view.frame
        view.layer.insertSublayer(backgroundLayer, atIndex: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func foundUserLocation(longitude: String, latitude: String) -> Void { //TODO: Refactor to event listener
        weatherService.parent = self
        weatherService.getWeatherDetails(longitude, userLatitude: latitude)
    }
    
    func didGetWeatherDetails(weatherDetails: WeatherDetails) -> Void { //TODO: Refactor to event listener
        self.weatherDetails = weatherDetails
        self.setDisplayValues(weatherDetails)
    }
    
    func setDisplayValues(weatherDetails: WeatherDetails) -> Void {
        dispatch_async(dispatch_get_main_queue()) {
            self.loading.stopAnimating()
            self.locationLabel.text = weatherDetails.location
            self.temperatureLabel.text = String(format: "%.0f", weatherDetails.averageTemperature.celcius)
            self.forecastLabel.text = weatherDetails.forecast
            self.humidityLabel.text = String(format: "%.1f", weatherDetails.humidity)
            self.windSpeedLabel.text = String(format: "%.1f", weatherDetails.windspeed)
            self.sunriseLabel.text = weatherDetails.sunrise
            self.sunsetLabel.text = weatherDetails.sunset
        }
    }

}