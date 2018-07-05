//
//  Configuration.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class Configuration: HostConfiguration {
    public var scheme: HostScheme
    public var host: String
    
    public init(scheme: HostScheme = .https, host: String) {
        self.scheme = scheme
        self.host = host
    }
}
