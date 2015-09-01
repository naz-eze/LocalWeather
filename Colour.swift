//
//  Colour.swift
//  Local Temperature
//
//  Created by Naz on 31/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import Foundation
import UIKit

class Colours: NSObject {
    
    //TODO: These values should ideally be set externally in some sort of properties files
    //      to allow for easy maintenance/configuration
    
    private let freezingTempRange = -100...0
    private let coldTempRange = 1...13
    private let normalTempTange = 14...20
    private let warmTempRange = 21...30
    private let boilingTempRange = 31...100
    
    private let coralBlue = RGB(red: 69, green: 81, blue: 171)
    private let royalBlue = RGB(red: 65, green: 105, blue: 225)
    private let lightSkyBlue = RGB(red: 135, green: 206, blue: 250)
    private let gold = RGB(red: 255, green: 215, blue: 0)
    private let orange = RGB(red: 255, green: 69, blue: 0)
    private let carrot = RGB(red: 238, green: 44, blue: 44)
    private let goldenRod = RGB(red: 255, green: 193, blue: 37)
    
    private var colourTop: CGColor
    private var colourBottom: CGColor
    
    private let TWO_FIVE_FIVE:CGFloat = 255.0
    
    var colourGradient: CAGradientLayer
    
    override init () {
        colourGradient = CAGradientLayer()
        
        colourTop = UIColor(red: coralBlue.red/TWO_FIVE_FIVE,
                            green: coralBlue.green/TWO_FIVE_FIVE,
                            blue: coralBlue.blue/TWO_FIVE_FIVE, alpha: 1.5).CGColor
        
        colourBottom = UIColor( red: lightSkyBlue.red/TWO_FIVE_FIVE,
                                green: lightSkyBlue.green/TWO_FIVE_FIVE,
                                blue: lightSkyBlue.blue/TWO_FIVE_FIVE, alpha: 1.5).CGColor
    }
    
    func createGradient() -> Void {
        colourGradient.colors = [ colourTop, colourBottom]
        colourGradient.locations = [ 0.0, 1.0]
    }
    
    func createBackgroundImage(weatherDetails: WeatherDetails) -> Void {
        
        var tempValue = Int (weatherDetails.averageTemperature.celcius)
        
        switch tempValue {
        case freezingTempRange:
            setTopBottomColourValues(coralBlue, bottom: royalBlue)
            
        case coldTempRange:
            setTopBottomColourValues(royalBlue, bottom: lightSkyBlue)
            
        case normalTempTange:
            setTopBottomColourValues(lightSkyBlue, bottom: gold)
            
        case warmTempRange:
            setTopBottomColourValues(gold, bottom: orange)
            
        case boilingTempRange:
            setTopBottomColourValues(goldenRod, bottom: carrot)
        default:
            break;
        }
    }
    
    private func setTopBottomColourValues(top:RGB, bottom:RGB) -> Void {
        
        colourTop = UIColor(red: top.red/TWO_FIVE_FIVE,
            green: top.green/TWO_FIVE_FIVE,
            blue: top.blue/TWO_FIVE_FIVE, alpha: 1.5).CGColor
        
        colourBottom = UIColor( red: bottom.red/TWO_FIVE_FIVE,
            green: bottom.green/TWO_FIVE_FIVE,
            blue: bottom.blue/TWO_FIVE_FIVE, alpha: 1.5).CGColor
    }
    
}


struct RGB {
    var red:CGFloat
    var green:CGFloat
    var blue:CGFloat
}