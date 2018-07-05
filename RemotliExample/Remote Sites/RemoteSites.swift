//
//  NetworkConfiguration.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

// This class demonstrates factory creation of configuration objects for the sites the app will be
// accessing during it's lifecycle.
// Static functions within this class generate Configuration objects that represent
// the remote host.
// The default scheme configuration setting is .https.
class RemoteSites {
    
    // Defines a remote host with an explicit .https scheme set as an example, if not set
    // https is set by default.
    static func demo1() -> Configuration {
        return Configuration(scheme: .https, host: "remotli.sudomedia.com")
    }
    
    // Defines a second remote host.
    static func demo2() -> Configuration {
        return Configuration(host: "remotli.sudomedia.com")
    }
}
