//
//  AggregateResponsePlugin.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class AggregateResponsePlugin: ResponsePlugin {
    
    public var identifier = ResponsePluginIdentifier.aggregate.description
    
    var plugins: [ResponsePlugin]
    
    public required init(plugins: [ResponsePlugin]) {
        self.plugins = plugins
    }
    
    public func add(_ plugin: ResponsePlugin) {
        plugins.append(plugin)
    }
    
    public func didReceive<T: Codable>(_ response: URLResponse?, data: Data?, error: Error?, forRequest request: URLRequest, completion: @escaping (T?, Error?) -> Void) -> Bool {
        
        // iterate response plugins
        for plugin in plugins {
            
            // if the plugin handled the response then return true
            if plugin.didReceive(response, data: data, error: error, forRequest: request, completion: completion) {
                return true
            }
        }
        
        // either no plugin handled the response or no plugins were configured to handle the response
        completion(nil, NetworkError.noAvailablePlugin)
        
        // response unhandled, return false
        return false
    }
}
