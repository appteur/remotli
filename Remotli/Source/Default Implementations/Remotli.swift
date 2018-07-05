//
//  Remotli.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

open class Remotli: Remotely {
    
    public var config: HostConfiguration
    public var reachability: NetworkAccessibilityProvider?
    public var session: URLSession
    
    public var requestPlugin: RequestPlugin?
    public var responsePlugin: ResponsePlugin?
    
    public convenience init(host: String) {
        let config = Configuration(host: host)
        self.init(configuration: config)
    }
    
    public init(configuration: HostConfiguration, session: URLSession = URLSession.shared, useReachability: Bool = true) {
        self.config = configuration
        self.session = session
        
        if useReachability {
            reachability = NetworkReachability.init(host: config.host)
        }
        
        requestPlugin = AggregateRequestPlugin.init(plugins: [
            GetParametersPlugin(),
            PostJsonPlugin(),
            PostUrlEncodedPlugin(),
            FormDataPlugin(),
            RequestHeaderPlugin(),
            RequestLoggerPlugin()
            ]
        )
        
        responsePlugin = AggregateResponsePlugin.init(plugins: [
            ResponseLoggerPlugin(),
            ResponseErrorPlugin(),
            JSONResponseParserPlugin()
            ]
        )
        setup()
    }
    
    open func setup() {
        // hook for subclasses to perform additional setup if needed
    }
}
