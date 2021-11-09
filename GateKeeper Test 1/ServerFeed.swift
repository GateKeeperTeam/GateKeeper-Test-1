//
//  ServerFeed.swift
//  GateKeeper Test 1
//
//  Created by Thomas Lyons on 11/9/21.
//

import Foundation

struct ServerFeed : Codable {
    
    var fullName : String = ""
    var badgeLocation : String = "39.1329° N, 84.5150° W" // or use as double, Lat and Long seperately
    var badgeLocationLat : Double = 39.1329
    var badgeLocationLong: Double = 84.5150
    var userLocation: String = ""
    var userLocationLat : Double
    var userLocationLong : Double
    var userIsAuthenticated : Bool = false // or string?
    var userConnectionString : String? //  ? = optional
    
}
