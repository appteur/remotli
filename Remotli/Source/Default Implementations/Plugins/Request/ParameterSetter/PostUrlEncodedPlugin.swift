//
//  PostUrlEncodedPlugin.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class PostUrlEncodedPlugin: RequestPlugin {
    
    public var identifier = RequestPluginIdentifier.postUrlEncoded.description
    
    public init() {
        // here for conformance with convention
    }

    public func configure(_ request: inout URLRequest, for routable: Routable) {
        
        guard routable.method == .post || routable.method == .put,
            routable.mimeType == .applicationFormUrlEncoded,
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
        
        // generate url encoded string
        let parameters = params.compactMap { (key, value) -> String? in
            return "\(key)=\(value)"
        }
        
        let data = parameters.joined(separator: "&").data(using: .utf8)
        
        return data
    }
}
