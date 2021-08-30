//
//  LocationManager.swift
//  UppSense
//
//  Created by Jayendra Prashanth  on 01/08/21.
//

import Foundation
import MapKit
import Combine

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    private let geocoder = CLGeocoder()
    @Published var placemark: CLPlacemark?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        })
    }
}
