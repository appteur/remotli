//
//  BlueteamClient.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

/// This class is a representation of a remote web api.
/// It makes use of public initializers on the 'NetworkClient' superclass for
/// fast and easy setup.
class Demo1Client: Remotli {
    
    // Defines an api endpoint for fetching app configuration information from the remote
    // resource.
    // The route encapsulates information defining request info to be sent to the
    // remote api, such as uri, method, mimeType, headers, parameters, etc.
    // The completion specifies the expected model object representation of the
    // resource being returned from the remote api.
    func getAppConfig(completion: @escaping (AppConfig?, Error?) -> Void) {
        
        // define the route where the remote config resource lives
        let configRoute = Route(
            uri: "/api/demo1/app-config.json",
            method: .get,
            mimeType: .applicationFormUrlEncoded,
            parameters: defaultParameters()
        )
        
        // send the request to this route and pass in the completion
        send(requestFor: configRoute, completion: completion)
    }
    
    // illustrates another way to fetch the remote config without explicitly generating
    // a Route object.
    func getConfig2(completion: @escaping (AppConfig?, Error?) -> Void) {
        send("/api/demo1/app-config.json",
             method: .get,
             mimeType: MimeType.applicationFormUrlEncoded,
             parameters: defaultParameters(),
             completion: completion)
    }
    
    // This demonstrates a 3rd way to fetch from the remote api with a custom defined Route
    func getConfig3(completion: @escaping (AppConfig?, Error?) -> Void) {
        
        // send the request to the configuration route and pass in the completion
        send(requestFor: ConfigurationRoute(parameters: ["app_id": "demo_app_id", "token": "demo_token"]), completion: completion)
    }
    
    internal func defaultParameters() -> [String: Any] {
        return [
            "app_id": "demo_app_id",
            "token": ""
        ]
    }
}
