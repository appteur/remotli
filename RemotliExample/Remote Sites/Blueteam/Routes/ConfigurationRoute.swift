//
//  Configuration.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

// This demonstrates a custom route that defines all info needed to get
// configuration data from a remote api.
class ConfigurationRoute: Routable {
    
    var method: HTTPMethod = .post
    var uri: String =  "/api/demo1/app-config.json"
    var mimeType: MimeType = .applicationFormUrlEncoded
    var port: Int?
    var headers: [String: String]?
    var parameters: [String: Any]?
    var requiresAuth: Bool = false
    
    init(parameters: [String: Any]?) {
        self.parameters = parameters
    }
}
