//
//  BasicAuthPlugin.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class BasicAuthPlugin: RequestPlugin {
    
    public var identifier = RequestPluginIdentifier.basicAuth.description
    var username: String
    var password: String
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    public func configure(_ request: inout URLRequest, for routable: Routable) {
        guard let base64String = basicAuth() else {
            return
        }
        
        request.addValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
    }
    
    internal func basicAuth() -> String? {
        
        let toBase64 = "\(username):\(password)"
        
        guard let dataToBase64 = toBase64.data(using: .utf8) else {
            return nil
        }
        
        return dataToBase64.base64EncodedString()
    }
}
