//
//  AuthViewModel.swift
//  GateKeeper Test 1
//
//  Created by Thomas Lyons on 10/26/21.
//

import Foundation
import LocalAuthentication
import UIKit

class AuthViewModel: ObservableObject {
    
    @Published var isAppLockEnabled: Bool = false
    @Published var isAppUnlocked:Bool = false
    
    init() {
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
                        self.isAppUnlocked = true
                       
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
    func alertView(){
    
        let alert = UIAlertController(title: "Badge Scanned", message: "If this was you -- complete verification Now.", preferredStyle: .alert)
    
        alert.addTextField { (pass) in
            
            pass.isSecureTextEntry = true
            pass.placeholder = "Password"
        }
    
        // Action Buttons ...
        
        let authenticate = UIAlertAction(title: "Authenticate", style: .default) { (_) in
            
        //do your own stuff..
            
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

