//
//  Colour.swift
//  Local Temperature
//
//  Created by Naz on 31/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import Foundation
import UIKit

//TODO: Background colour should dynamically change depending on temperature value

class Colours: NSObject {
    
    let colourTop = UIColor(red: 0/255.0, green: 191/255.0, blue: 255/255.0, alpha: 1.5).CGColor
    let colourBottom = UIColor(red: 205/255.0, green: 205/255.0, blue: 0/255.0, alpha: 1.5).CGColor
    
    let colourGradient: CAGradientLayer
    
    override init() {
        colourGradient = CAGradientLayer()
        colourGradient.colors = [ colourTop, colourBottom]
        colourGradient.locations = [ 0.0, 1.0]
    }
}
