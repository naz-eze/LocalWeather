//
//  ViewController.swift
//  Local Temperature
//
//  Created by Naz on 26/08/2015.
//  Copyright (c) 2015 nazchinaza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonRef: UIButton!
    
    @IBAction func getWeatherDetails(sender: UIButton) {
    
    }
    
    private func setButtonProperties() -> Void {
        buttonRef.layer.cornerRadius = 10;
        buttonRef.layer.borderWidth = 0.75;
        buttonRef.backgroundColor = UIColor.clearColor()
        buttonRef.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setButtonProperties()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

