//
//  AuthViewModel.swift
//  GateKeeper Test 1
//
//  Created by Thomas Lyons on 10/26/21.
//

import Foundation
import LocalAuthentication

class AuthViewModel: ObservableObject {
    @Published var isAppLockEnabled: Bool = false //app lock state for user is false //published because combined framework
    @Published var isAppUnlocked:Bool = false //
    
    init() {
        getAppLockState()
    }
    func enableAppLock() {
        UserDefaults.standard.set(true,forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
        self.isAppLockEnabled = true
    }
    func disableAppLock() {
        UserDefaults.standard.set(false,forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
        self.isAppLockEnabled = false
    }
    func getAppLockState() {
        isAppLockEnabled = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isAppLockEnabled.rawValue)
    }
    
    func checkIfBioMetricAvailable() -> Bool { // -> Bool, expecting function to return true or false
        var error:NSError? //LocalAuthentication uses Objective C erroring, so need NSError
        let laContext = LAContext()
        let isBiometricAvailable = laContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if let error = error{
            print(error.localizedDescription)
        }
        return isBiometricAvailable
    }
    
    func appLockStateChange(appLockState:Bool) {
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
    
    func appLockValidation(){
        let laContext = LAContext()
        if checkIfBioMetricAvailable(){
            let reason = "Enable App Lock"
            laContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){(success, error) in
                if success{
                    DispatchQueue.main.async {
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
    
}

enum UserDefaultsKeys:String {
    case isAppLockEnabled
}
