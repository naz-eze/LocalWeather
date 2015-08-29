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
    @IBOutlet weak var visibilityLabel: UILabel!
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
    
    func foundUserLocation(longitude: String, latitude: String) -> Void {
        weatherService.getWeatherDetails(longitude, userLatitude: latitude)
    }
    
    private func setButtonProperties() -> Void {
        buttonRef.layer.cornerRadius = 10;
        buttonRef.layer.borderWidth = 0.75;
        buttonRef.backgroundColor = UIColor.clearColor()
        buttonRef.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

}

