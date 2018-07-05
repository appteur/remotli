//
//  ApiErrorMap.swift
//  RemotliExample
//
//  Created by Seth on 6/3/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

// This extension provides a coding keys map for the default ErrorResponse class provided
// by Remotli to map api keys to local model keys during json parsing if an error
// is generated and returned by the remote api.
extension ErrorResponse {
    
    enum CodingKeys: String, CodingKey {
        case name
        case type = "error_type"
        case description = "error_description"
        case detail = "error_detail"
        case status
    }
}
