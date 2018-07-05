//
//  Router.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

// This demonstrates a remote web service that requires additional configuration and
// performs it by overriding the 'setup' function. The setup function
// is called by the superclass immediately following initialization.
class Demo2Client: Remotli {

//    convenience init() {
//        self.init(host: "my-host-api.com")
//    }
    
    // Sets up an additional basic auth plugin with username/password.
    // This will configure all outgoing requests to this remote host with an
    // Authentication header set with a basic auth token value.
    override func setup() {
        addRequestPlugin(BasicAuthPlugin.init(username: "myBasicAuth", password: "secret"))
    }
    
    // Fetches the token from this remote host, making use of a route initializer and
    // specifying that an anonymous token is being requested.
    func getToken(completion: @escaping (Token?, Error?) -> Void) {
        send(requestFor: TokenRoute.credential, completion: completion)
    }
    
    // Logs in to this remote host and returns a User model object if successful.
    // Makes use of a route initializer for convenience.
    func login(username: String, password: String, completion: @escaping (User?, Error?) -> Void) {
        let route = UserRoute.login(username: username, password: password)
        send(requestFor: route, completion: completion)
    }
}
