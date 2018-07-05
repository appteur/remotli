//
//  ResponsePluginIdentifier.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

enum ResponsePluginIdentifier: CustomStringConvertible {
    
    case aggregate
    case error
    case jsonParser
    case logger
    
    var description: String {
        let prefix = "remotli.plugin.response."
        switch self {
        case .aggregate:
            return prefix+"aggregate"
        case .error:
            return prefix+"responseError"
        case .jsonParser:
            return prefix+"parser.json"
        case .logger:
            return prefix+"logger"
        }
    }
}
