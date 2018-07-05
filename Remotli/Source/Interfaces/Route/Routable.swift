//
//  Routable.swift
//  Remotli
//
//  Created by Seth on 5/25/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public protocol Routable {
    var uri: String { get }
    var port: Int? { get }
    var method: HTTPMethod { get }
    var mimeType: MimeType { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var requiresAuth: Bool { get }
    
    var timeout: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension Routable {
    public var timeout: TimeInterval {
        return 60
    }
    
    public var cachePolicy: URLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }
    
    public func route() -> Route {
        return Route(uri: uri, port: port, method: method, mimeType: mimeType, headers: headers, parameters: parameters, requiresAuth: requiresAuth)
    }
}
