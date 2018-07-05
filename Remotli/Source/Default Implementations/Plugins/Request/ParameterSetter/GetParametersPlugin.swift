//
//  GetParametersPlugin.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class GetParametersPlugin: RequestPlugin {
    
    public var identifier = RequestPluginIdentifier.getParameters.description
    
    public init() {
         // here for conformance with convention
    }
    
    public func configure(_ request: inout URLRequest, for routable: Routable) {
        
        guard request.httpMethod == "GET" else {
            return
        }
        
        // get the current base url path for our request
        guard let path = request.url?.absoluteString else {
            print("Failure to add GET parameters to request, unable to parse request path from url: \(String(describing: request.url))")
            return
        }
        
        guard let params = routable.parameters else {
            return
        }
        
        // create our url components from the current base path
        var urlComponents = URLComponents.init(string: path)
        
        // this will be all our GET request query items
        var queryItems: [URLQueryItem] = []
        
        // enumerate our parameters and create query items to generate our url
        for (key,value) in params {
            guard let val = value as? String else {
                print("Unable to add query item to GET request, value is not a string: \(value)")
                continue
            }
            
            let query = URLQueryItem(name: key, value: val)
            queryItems.append(query)
        }
        
        // update our url for this request
        urlComponents?.queryItems = queryItems
        request.url = urlComponents?.url
    }
}
