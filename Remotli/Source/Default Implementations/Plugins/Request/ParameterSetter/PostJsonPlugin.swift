//
//  PostParametersPlugin.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class PostJsonPlugin: RequestPlugin {
    
    public var identifier = RequestPluginIdentifier.postJson.description
    
    public init() {
        // here for conformance with convention
    }
    
    public func configure(_ request: inout URLRequest, for routable: Routable) {
        
        guard routable.method == .post || routable.method == .put,
            routable.mimeType == .applicationJson,
            let body = body(for: routable) else {
            return
        }
        
        request.httpBody = body
        request.addValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        request.addValue("\(routable.mimeType.description); charset=utf-8", forHTTPHeaderField: routable.mimeType.headerName)
    }
    
    internal func body(for routable: Routable) -> Data? {
        guard let params = routable.parameters else {
            return nil
        }
        
        // try converting to json
        guard let data = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            print("Failed to convert post vars: \(params)")
            return nil
        }
        
        return data
    }
}
