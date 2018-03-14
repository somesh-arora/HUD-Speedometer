//
//  ViewController.swift
//  locationSpeed
//
//  Created by Somesh Arora on 9/7/17.
//  Copyright © 2017 St. Jude Medical. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate
{
    
    @IBAction func daylightButton(_ sender: Any)
    {
        if(StatusLabel.backgroundColor != UIColor.white)
        {
            StatusLabel.backgroundColor = UIColor.white
            StatusLabel.textColor = UIColor.black
            unitLabel.textColor = UIColor.black
            DirectionLabel.textColor = UIColor.black
        }
    }
    
    @IBAction func nightTimeButton(_ sender: Any)
    {
        if(StatusLabel.backgroundColor != UIColor.black)
        {
            StatusLabel.backgroundColor = UIColor.black
            StatusLabel.textColor = UIColor.green
            unitLabel.textColor = UIColor.green
            DirectionLabel.textColor = UIColor.green
        }
    }
    
    
    @IBAction func KphUnitButton(_ sender: Any)
    {
        speedUnitDecide = 1
    }
    
    
    @IBAction func MphSpeedUnit(_ sender: Any)
    {
        speedUnitDecide = 0
    }
    
    @IBOutlet weak var DirectionLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var StatusLabel: UILabel!
    let manager = CLLocationManager()
    var speed:Float = 0.0
    var intSpeed:Int = 0
    var speedUnit: Float = 0.0
    var speedUnitDecide: Int = 0
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        DirectionLabel.text = ""
        unitLabel.text = "Mph"
        unitLabel.transform = CGAffineTransform(scaleX: 1, y:-1)
        DirectionLabel.transform = CGAffineTransform(scaleX: 1, y:-1)
        let location = locations[0]
        print(locations[0])
        print("\n")
        print(location.course)
        let direction = location.course
        if(direction >= 0.0 && direction <= 45.0)
        {
            DirectionLabel.text = "North"
        }
        else if(direction > 45.0 && direction <= 90.0)
        {
            DirectionLabel.text = "N E"
        }
        else if(direction > 90.0 && direction <= 135.0)
        {
           DirectionLabel.text = "East"
        }
        else if(direction > 135.0 && direction <= 180.0)
        {
            DirectionLabel.text = "S E"
        }
        else if(direction > 180.0 && direction <= 225.0)
        {
            DirectionLabel.text = "South"
        }
        else if(direction > 225.0 && direction <= 270.0)
        {
            DirectionLabel.text = "S W"
        }
        else if(direction > 270.0 && direction <= 315.0)
        {
            DirectionLabel.text = "West"
        }
        else if(direction > 315.0 && direction <= 360.0)
        {
            DirectionLabel.text = "N W"
        }
        else
        {
            DirectionLabel.text = ""
        }
        
        
        speed = (Float(location.speed) * 3.6 * 0.621371)
        if(speedUnitDecide == 1)
        {
            speed = (Float(location.speed) * 3.6)
            unitLabel.text = "Kph"
        }
        
        intSpeed = Int(speed)
        print("Current Speed is \(intSpeed) Mph")
        if(location.speed < 0.0)
        {
            StatusLabel.text = "0"
            DirectionLabel.text = ""
        }
        else
        {
            StatusLabel.text = "\(intSpeed)"
            StatusLabel.transform = CGAffineTransform(scaleX: 1, y:-1)
            if((intSpeed > 75 && speedUnitDecide == 0) || (intSpeed > 120 && speedUnitDecide == 1))
            {
                StatusLabel.textColor = UIColor .red
                unitLabel.textColor = UIColor.red
                DirectionLabel.textColor = UIColor.red
            }
            else
            {
                StatusLabel.textColor = UIColor .green
                unitLabel.textColor = UIColor.green
                 DirectionLabel.textColor = UIColor.green
                
                if(StatusLabel.backgroundColor == UIColor.white)
                {
                    StatusLabel.textColor = UIColor.black
                    unitLabel.textColor = UIColor.black
                     DirectionLabel.textColor = UIColor.black
                }
            }
            
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

