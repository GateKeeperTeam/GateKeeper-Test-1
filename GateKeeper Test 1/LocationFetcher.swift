//
//  LocationFetcher.swift
//  GateKeeper Test 1
//
//  Created by Thomas Lyons on 11/2/21.
//

import Foundation
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLat: CLLocationDegrees? //changed from CLLocation...
    var lastKnownLong: CLLocationDegrees?
    var badgeLocationLat: Double = 39.1329
    var badgeLocationLong: Double = 84.5150
    
    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLat = locations.first?.coordinate.latitude
        lastKnownLong = locations.first?.coordinate.longitude
}
    func compareLocation(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLat = locations.first?.coordinate.latitude
        lastKnownLong = locations.first?.coordinate.longitude
        
        //see if user location is near badge scanner
       /* if lastKnownLong <= (badgeLocationLong + 0.5)??, //could make a smaller value -- worth testing
            lastKnownLat <= (badgeLocationLat + 0.5)
            &&
            lastKnownLong >= (badgeLocationLong - 0.5),
            lastKnownLat >= (badgeLocationLat - 0.5)
        {
            print ("Near the scanner")
            
            //
        }
        */
    }
}
