//
//  PluginIdentifier.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public enum RequestPluginIdentifier: CustomStringConvertible {
    
    case aggregateRequest
    case basicAuth
    case jwtAuth
    case logger
    case formData
    case getParameters
    case postJson
    case postUrlEncoded
    
    public var description: String {
        let prefix = "remotli.plugin.request."
        switch self {
        case .aggregateRequest:
            return prefix+"aggregate"
        case .basicAuth:
            return prefix+"auth.basic"
        case .jwtAuth:
            return prefix+"auth.jwt"
        case .logger:
            return prefix+"logger"
        case .formData:
            return prefix+"formdata"
        case .getParameters:
            return prefix+"query"
        case .postJson:
            return prefix+"postJson"
        case .postUrlEncoded:
            return prefix+"urlencoded"
        }
    }
}
