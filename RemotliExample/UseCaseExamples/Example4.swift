//
//  ViewModel3.swift
//  RemotliExample
//
//  Created by Seth on 7/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

// This example demonstrates the setup and configuration of a custom Remotli subclass
// with a custom Configuration and URLSession instance for more control over the
// request process.
class Example4 {
    
    internal var demo2: Demo2Client
    
    init() {
        
        // setup and configure custom url session
        let urlConfig = URLSessionConfiguration.init()
        urlConfig.allowsCellularAccess = true
        urlConfig.httpCookieAcceptPolicy = .always
        let urlSession = URLSession.init(configuration: urlConfig)
        
        // setup api with custom configuration and url session
        let apiConfig = Configuration(scheme: .https, host: "remotli.sudomedia.com")
        demo2 = Demo2Client(configuration: apiConfig, session: urlSession)
    }
    
}
