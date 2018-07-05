//
//  Route.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

open class Route: Routable {
    public var uri: String
    public var port: Int?
    public var method: HTTPMethod
    public var mimeType: MimeType
    public var headers: [String : String]?
    public var parameters: [String : Any]?
    public var requiresAuth: Bool
    
    public init(uri: String, port: Int? = nil, method: HTTPMethod = .post, mimeType: MimeType = .applicationJson, headers: [String: String]? = nil, parameters: [String: Any]? = nil, requiresAuth: Bool = false) {
        self.uri = uri
        self.port = port
        self.method = method
        self.mimeType = mimeType
        self.headers = headers
        self.parameters = parameters
        self.requiresAuth = requiresAuth
    }
}
