//
//  AuthViewModel.swift
//  GateKeeper Test 1
//
//  Created by Thomas Lyons on 10/26/21.
//

import Foundation
import LocalAuthentication
import UIKit
import CoreLocation

class AuthViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationFetcher = LocationFetcher()
    let manager = CLLocationManager()
    var lastKnownLat: CLLocationDegrees? //changed from CLLocation...
    var lastKnownLong: CLLocationDegrees?
    var badgeLocationLat: Double = 39.1
    var badgeLocationLong: Double = 84.5
    
    
    @Published var isAppLockEnabled: Bool = false
    @Published var isAppUnlocked:Bool = false
    
    override init() {
        super.init()
        manager.delegate = self
        getAppLockState()
        
        
    }
    
    /*
     func enableAppLock() {
     UserDefaults.standard.set(true,forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
     self.isAppLockEnabled = true
     }
     func disableAppLock() {
     UserDefaults.standard.set(false,forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
     self.isAppLockEnabled = false
     }
     
     */
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
    
    
    func getAppLockState() {
        isAppLockEnabled = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
    }
    
    func checkIfBioMetricAvailable() -> Bool { //Checks if device has Biometric, returns true or false value
        var error:NSError?
        let laContext = LAContext()
        let isBiometricAvailable = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error{
            print(error.localizedDescription) //Catch and print errors if something goes wrong
        }
        return isBiometricAvailable
    }
    
    /* func appLockStateChange(appLockState:Bool) {
     let laContext = LAContext()
     if checkIfBioMetricAvailable(){
     var reason = ""
     if appLockState{
     reason = "Provide TouchID / FaceID to enable App Lock"
     }
     else{
     reason = "Provide TouchID / FaceID to disable App Lock"
     }
     laContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason){ (success,error) in
     if success{
     if appLockState{
     DispatchQueue.main.async {
     self.enableAppLock()
     self.isAppUnlocked = true
     }
     }
     else{
     DispatchQueue.main.async {
     self.disableAppLock()
     self.isAppUnlocked = true
     }
     }
     }
     else{
     if let error = error{
     DispatchQueue.main.async {
     print(error.localizedDescription)
     }
     }
     }
     }
     }
     }
     
     */
    
    
    func appLockValidation(){ //need this to do auth.
        let laContext = LAContext()
        if checkIfBioMetricAvailable(){
            let reason = "Enable App Lock"
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){(success, error) in
                if success{
                    print ("success")
                    
                    // self.locationCheck() //trigger second auth method
                    
                    
                    DispatchQueue.main.async { // add what happens on successful authentication
                        //self.isAppUnlocked = true  //not sure this is necessary, returned to login page after completion
                        
                        //self.locationCheck()
                        self.start()
                    }
                    
                    
                    DispatchQueue.main.async { // add what happens on successful authentication
                        //self.isAppUnlocked = true  //not sure this is necessary, returned to login page after completion
                        
                        //self.locationCheck()
                        if let longitude = self.lastKnownLong, let latitude = self.lastKnownLat {
                           let badgeLocationLat : Double = 39.1
                           let badgeLocationLong: Double = 84.5
                            
                            print("Your Longitude is \(longitude)")
                            print ("Your Latitude is \(latitude)")
                           // LocationFetcher.compareLocation()
                            //see if user location is near badge scanner
                            if longitude <= (badgeLocationLong + 0.5), //could make a smaller value -- worth testing
                                latitude <= (badgeLocationLat + 0.5)
                                &&
                                longitude >= (badgeLocationLong - 0.5),
                                latitude >= (badgeLocationLat - 0.5)
                            {
                                print ("Near the scanner")
                                
                                //pass success popup to user
                                // log to server
                                // return success to server
                            }
                          
                        } else {
                            print("Your location is unknown")
                            print(self.lastKnownLat!)
                            print(self.lastKnownLong!)
                            
                            //pass popup to user
                            //log and return failure to server
                            //return failure to server
                        }
                          
                    }
                    
                    
                }
                else{
                    if let error = error{
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                            print("Error: FaceID Failed")
                        }
                    }
                }
            }
        }
    }
    
    
    func locationCheck(){
        
        let laContext = LAContext()
        if checkIfBioMetricAvailable(){
            let reason = "Enable Authentication"
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){(success, error) in
                if success{
                    
                }
            }
        }
    }
    
    func compareLocations(){
        
        
        if let longitude = self.locationFetcher.lastKnownLong, let latitude = self.locationFetcher.lastKnownLat {
            let badgeLocationLat : Double = 39.1
            let badgeLocationLong: Double = 84.5
            
            print("Your Longitude is \(longitude)")
            print ("Your Latitude is \(latitude)")
            // LocationFetcher.compareLocation()
            //see if user location is near badge scanner
            if longitude <= (badgeLocationLong + 0.5), //could make a smaller value -- worth testing
               latitude <= (badgeLocationLat + 0.5)
                &&
                longitude >= (badgeLocationLong - 0.5),
               latitude >= (badgeLocationLat - 0.5)
            {
                print ("Near the scanner")
                
                //
            }
            
        } else {
            print("Your location is unknown")
        }
    }
    func alertView(){
        
        let alert = UIAlertController(title: "Badge Scanned", message: "If this was you -- complete verification Now.", preferredStyle: .alert)
        
        alert.addTextField { (pass) in
            
            pass.isSecureTextEntry = true
            pass.placeholder = "Password"
        }
        
        // Action Buttons ...
        
        let authenticate = UIAlertAction(title: "Authenticate", style: .default) { (_) in
            
            //do your own stuff..
            self.appLockValidation()
            // retrieving password
            
            // password = alert.textFields![0].text!
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) {(_) in
            
            // do own stuff
            
        }
        // add into alertview
        alert.addAction(cancel)
        alert.addAction(authenticate)
        
        // presenting alertview
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            // do your own stuff
        })
        
    }
    
    
}


enum UserDefaultsKeys:String {
    case isAppLockEnabled
}

