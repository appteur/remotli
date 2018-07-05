//
//  ViewModel2.swift
//  RemotliExample
//
//  Created by Seth on 7/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

// This example demonstrates a setup where multiple remote hosts are called, and each
// host has it's own custom subclass of Remotli that implement functions to encapsulate
// each request and handle each route. The subclasses act as the central wrapper around
// the remote api.
// The instantiation of the remote client classes also makes use of another initializer
// that takes a HostConfiguration object instead of using the init(host:)
// function from prior examples.
// Additionally a factory class has been created to setup and vend a configuration
// for each host that will be called.
class Example3 {
    
    // 2 remote sites that will be accessed
    internal var demo1: Demo1Client
    internal var demo2: Demo2Client
    
    init() {
        
        // setup the sites we'll be accessing using the factory to provide the configuration
        demo1 = Demo1Client(configuration: RemoteSites.demo1())
        demo2 = Demo2Client(configuration: RemoteSites.demo2())
    }
    
    
    func fetchToken() {
        
        // get token from te2 site
        demo2.getToken() { (token: Token?, error) in
            
            // validate
            guard let token = token, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            print("\tAccessToken: \(String(describing: token.accessToken))")
            print("\tTokenType: \(String(describing: token.tokenType))")
            print("\tiss: \(String(describing: token.iss))")
            print("\tExpiresIn: \(String(describing: token.expiresIn))")
        }
    }
    
    
    func fetchAppConfig() {
        
        // fetch config from bts site
        demo1.getAppConfig() { (config: AppConfig?, error) in
            guard let config = config, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            print("Config: \(String(describing: config))")
            print("\tShow Ads: \(String(describing: config.showAds))")
            print("\tCurrent Version: \(String(describing: config.currentVersion))")
        }
    }
    
    
    func login(email: String, password: String) {
        
        // login to te2 site
        demo2.login(username: email, password: password) { (user: User?, error) in
            guard let user = user, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            print("User: \(String(describing: user.identifier))")
            print("Name: \(String(describing: user.firstName))")
        }
    }
    
}
