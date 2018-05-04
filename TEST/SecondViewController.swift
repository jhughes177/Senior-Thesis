//
//  SecondViewController.swift
//  TEST
//
//  Created by Jared Hughes on 11/29/17.
//  Copyright © 2017 Jared Hughes. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController,CLLocationManagerDelegate {

    //Map of user
    
    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
        let location = locations[0]
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let userLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(userLocation,span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
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

