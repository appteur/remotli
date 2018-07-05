//
//  UserRoutes.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

// Defines a class based route that uses static functions as custom initializers.
// This is an alternate method to using an enum.
class UserRoute: Route {
    
    static let uri: String = "/api/demo2/user.json"
    static let method: HTTPMethod = .get
    static let mimetype: MimeType = .applicationJson
    static var defaultHeaders: [String: String] = [
        :
    ]
}

extension UserRoute {
    
    // custom Route initializer that sets up a login route with custom parameters
    static func login(username: String, password: String) -> UserRoute {
        return UserRoute(
            uri: uri,
            port: nil,
            method: method,
            mimeType: mimetype,
            headers: defaultHeaders,
            parameters: [
                "name": username,
                "credentialType": "CREDENTIAL",
                "credential": password
            ],
            requiresAuth: false
        )
    }
}
