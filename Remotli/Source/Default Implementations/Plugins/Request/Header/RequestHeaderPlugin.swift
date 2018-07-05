//
//  RequestHeaderPlugin.swift
//  Remotli
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class RequestHeaderPlugin: RequestPlugin {

    public var identifier: String = ""
    
    public init() {
        // here for conformance with convention
    }

    public func configure(_ request: inout URLRequest, for routable: Routable) {
        guard let headers = routable.headers, headers.isEmpty == false else {
            return
        }
        
        headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
    }
}
