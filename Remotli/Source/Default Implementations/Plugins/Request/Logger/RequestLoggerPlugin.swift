//
//  RequestLoggerPlugin.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class RequestLoggerPlugin: RequestPlugin {
    
    public var identifier = RequestPluginIdentifier.logger.description
    
    public init() {
        // here for conformance with convention
    }

    public func configure(_ request: inout URLRequest, for routable: Routable) {
        print("\n")
        print("----- ***** Remotli Request -----")
        print("\tURL: \(String(describing: request.url?.absoluteString))")
        print("\tMethod: \(String(describing: request.httpMethod))")
        print("\tHeaders: \(String(describing: request.allHTTPHeaderFields))")
        if let data = request.httpBody {
            let body = String.init(data: data, encoding: .utf8)
            print("\tBody: \(String(describing: body))")
        }
        print("----- ***** -----")
        print("\n")
    }
}
