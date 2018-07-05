//
//  Example2.swift
//  RemotliExample
//
//  Created by Seth on 7/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

// This example demonstrates the use of a custom subclass of Remotli, where the api calling
// details are implemented in the custom subclass.
class Example2 {
    
    // This remote host makes use of a custom subclass of Remotli, but still utilizes the
    // convenience init(host:) initializer.
    internal var demo1 = Demo1Client(host: "remotli.sudomedia.com")
    
    func fetchConfig() {
        
        // the custom subclass implements api calling functions and obfuscates details
        // that do not need to be exposed to the caller.
        demo1.getAppConfig() { (config: AppConfig?, error) in
            
            // validate
            guard let config = config, error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            print("Config: \(String(describing: config))")
            print("\tShow Ads: \(String(describing: config.showAds))")
            print("\tCurrent Version: \(String(describing: config.currentVersion))")
            
            // do something with config information...
        }
    }
}
