//
//  ViewController.swift
//  OndeEuEstou
//
//  Created by Iuri Menin on 04/08/16.
//  Copyright © 2016 Iuri Menin. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var manager:CLLocationManager!
    
    @IBOutlet weak var latutideLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var cursoLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var velocidadeLabel: UILabel!
    @IBOutlet weak var enderecoProximoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        let userLocation:CLLocation = locations[0]
        
        self.latutideLabel.text = "\(userLocation.coordinate.latitude)"
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        self.cursoLabel.text = "\(userLocation.course)"
        self.altitudeLabel.text = "\(userLocation.altitude)"
        self.velocidadeLabel.text = "\(userLocation.speed)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placeMarks, error) in
            
            if error != nil {
                print(error)
            } else {
                
                let placeMark = placeMarks?[0]
                
                let userPlaceMark = CLPlacemark(placemark: placeMark!)

                self.enderecoProximoLabel.text = "\(userPlaceMark.subLocality) \(userPlaceMark.subAdministrativeArea) \(userPlaceMark.postalCode) \(userPlaceMark.country)"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

