//
//  GateKeeper_Test_1App.swift
//  GateKeeper Test 1
//
//  Created by Thomas Lyons on 10/15/21.
//

import SwiftUI

@main
struct GateKeeper_Test_1App: App {
    @StateObject var appLockVM = AuthViewModel()
   // @Environment(\.scenePhase) var scenePhase
    //var body: some Scene {
        //WindowGroup {
           // ContentView()
        //}
   // }
    
    
    @State var blurRadius: CGFloat = 0
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(appLockVM)
               /* .blur(radius: blurRadius)
                .onChange(of: scenePhase, perform: { value in
                    switch value{
                    case .active:
                        blurRadius = 0
                    case .background:
                        appLockVM.isAppUnlocked = false
                    case .inactive:
                        blurRadius = 5
                    @unknown default:
                        print("unknown")
                    }
                })
             */
        }
    }
}
