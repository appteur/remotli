//
//  ErrorResponse.swift
//  Remotli
//
//  Created by Seth on 6/3/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

/// Model object for errors returned from a remote api.
public class ErrorResponse: Codable {
    var name: String?
    var type: String?
    var description: String?
    var detail: String?
    var status: Int?
}
