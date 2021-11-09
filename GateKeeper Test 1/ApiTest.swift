//
//  ApiTest.swift
//  GateKeeper Test 1
//
//  Created by Thomas Lyons on 11/9/21.
//




/*
 
 
 
 
https://www.youtube.com/watch?v=_TrPJQWD8qs&t=6s

 
 

 
import Foundation
import UIKit

//override func viewDidLoad () { // i dont know what this does
   // super.viewDidLoad()
    // do additional setup after loading the view
    
    // hit the API endpoint
    let urlString = "" // API call addresss here, some URL, or local host ???
    
    let url = URL (string: urlString) // Create URL Session
    
    guard url != nil else { //Prevent URL from being NULL
        return
    }
    let session = URLSession.shared //create URL session
    
    let dataTask = session.dataTask(with: url!) { (data, response, error) in
        // enter URL to hit, and code to run when we get a response back
    
        //check for errors
        if error == nil && data != nil {
            //parse JSON
            let decoder = JSONDecoder()
            
            do {
                
           let serverFeed = try decoder.decode(ServerFeed.self, from: data!)
            
                print (serverFeed)
            }
            catch {
                print ("Error in JSON Parsing")
            }
        }
    
    }
    
    dataTask.resume() //fire off the dataTask -- make the API call
    
}
*/
