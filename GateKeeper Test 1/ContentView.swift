//
//  ContentView.swift
//  GateKeeper Test 1
//
//  Created by Thomas Lyons on 10/15/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appLockVM: AuthViewModel
    let locationFetcher = LocationFetcher()

    
    var body: some View {
        
        NavigationView{
            VStack{
                Image ("logo")
                    .resizable()
                    .scaledToFit()
                
                Text ("GateKeeper")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                NavigationLink(
                    destination:SignInView(),
                    label: {
                        Text("Press to Continue")
                            //Eventually a loading screen?
                            .foregroundColor(.secondary)
                            .font(.title)
                    })
                
            }
            // .navigationTitle("Welcome")
        }
    }
}

struct SignInView: View {
    @EnvironmentObject var appLockVM: AuthViewModel
    var body: some View {
   
        
        
        
        VStack{
            
            Image ("logo")
                .resizable()
                .scaledToFit()
            Text ("Sign In")
                .padding()
                .font(.title)
            
            HStack{
                Text ("Email: ")
                TextField("Email address", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            HStack{
                Text ("Password: ")
                TextField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            }
            .padding()
            
            NavigationLink(
                destination: Dashboard(),
                label: {
                    Text("Login")
                        //Eventually a loading screen?
                        .foregroundColor(.secondary)
                        .font(.title)
                        .padding()
                })
            
            HStack{
                Text("New User?")
                    .padding(.top)
                NavigationLink(
                    destination: SignUpView(),
                    label: {
                        Text("Click here to sign up")
                            .padding(.top)
                        
                    }
                    
                )}
            // .navigationTitle("Sign in")
        }
    }
    
struct SignUpView: View {
    @EnvironmentObject var appLockVM: AuthViewModel
    var body: some View {
        
        
        
        VStack{
            
            Image ("logo")
                .resizable()
                .scaledToFit()
            Text ("Sign Up")
            
            HStack{
                Text ("Email: ")
                TextField("Email address", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            }
            
            HStack{
                Text ("Password: ")
                TextField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
            }
            
            
            NavigationLink(
                destination: Dashboard(),
                label: {
                    Text("Sign Up")
                        //Eventually a loading screen?
                        .foregroundColor(.secondary)
                        .font(.title)
                })
            
            
        }
        // .navigationTitle("Sign in")
    }
}




    
    struct Dashboard: View {
        @EnvironmentObject var authVM: AuthViewModel
        let locationFetcher = LocationFetcher()

        
        var body: some View {
            
            
            
            
           // NavigationView{
                VStack{
                    Text ("Dashboard")
                        .font(.largeTitle)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)


                    
                    //Spacer()
                    
                    Text ("Scan your badge at your workplace to begin authentication")
                        .padding()
                    
                  
                    
                    Text ("No previous or pending authentications")
                        .padding()
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)


                    
                    //Spacer()
                    
                    
                    Button("Face ID"){
                        authVM.appLockValidation()
                    }
                    .font(.largeTitle)
                    .padding()
                    //Spacer()
                    
                    Button("Start Tracking Location") {
                        self.locationFetcher.start()
                    }
                    .font(.largeTitle)
                    .padding()
                    //Spacer()

                    
                    Button("Read Location") {
                        if let location = self.locationFetcher.lastKnownLocation {
                            print("Your location is \(location)")
                        } else {
                            print("Your location is unknown")
                        }
                    }
                    .font(.largeTitle)
                    .padding()
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)

                    

                    
                    
                    
                    
                    
                    
                }
                
            
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar){
                        Spacer()
                        Button("Dashboard"){
                            //print("Dashboard tapped")
                        }
                        Spacer()
                        Button("Preferences"){
                            
                        }
                        Spacer()
                        Button("Help"){
                            
                        }
                        Spacer()
                        
                        
                        
                   // }
                }
            }
        }
        
        
    }
    
    // .navigationTitle("Sign in")
}






struct ContentView_Previews: PreviewProvider {
    //@EnvironmentObject var appLockVM: AppLockViewModel
    static var previews: some View {
        ContentView()
    }
}






