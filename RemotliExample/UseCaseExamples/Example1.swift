//
//  SimplestViewModel.swift
//  RemotliExample
//
//  Created by Seth on 7/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

// This example demonstrates the fastest and simplest way to use Remotely.
class Example1 {
    
    // Instantiates a Remotli object using just a host name.
    // Using this convenience initializer defaults the host scheme to https.
    internal var google = Remotli(host: "google.com")
    
    
    func search(term: String) {
        
        // simply call send with appropriate parameters, you can omit
        // parameters that are not needed.
        google.send("", method: HTTPMethod.get, mimeType: MimeType.applicationJson, parameters: ["searchTerm": term], usingAuth: false, completion: { (user: User?, error: Error?) in
            
        })
    }
}
