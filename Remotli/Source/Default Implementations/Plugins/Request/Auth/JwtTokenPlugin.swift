//
//  JWTTokenPlugin.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class JwtTokenPlugin: RequestPlugin {
    
    public var identifier = RequestPluginIdentifier.jwtAuth.description
    
    public init() {
        // here for conformance with convention
    }

    public func configure(_ request: inout URLRequest, for routable: Routable) {
        guard let token = UserDefaults.standard.value(forKey: "token") as? String else {
            print("ERROR:: -- TOKEN Auth -- Not setting token for request: [\(String(describing: request.url?.absoluteURL))] -- stored token not found")
            return
        }
        
        request.addValue("JWT "+token, forHTTPHeaderField: "Authorization")
    }
}
