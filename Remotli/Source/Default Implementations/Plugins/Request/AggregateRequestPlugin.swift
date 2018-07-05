//
//  AggregateRequestPlugin.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class AggregateRequestPlugin: RequestPlugin {
    
    public var identifier = RequestPluginIdentifier.aggregateRequest.description
    var plugins: [RequestPlugin]
    
    public required init(plugins: [RequestPlugin]) {
        self.plugins = plugins
    }
    
    public func add(_ plugin: RequestPlugin) {
        plugins.append(plugin)
    }
    
    public func configure(_ request: inout URLRequest, for routable: Routable) {
        plugins.forEach({ $0.configure(&request, for: routable) })
    }
}
