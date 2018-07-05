//
//  JSONSerializationError.swift
//  Networking
//
//  Created by Seth on 6/2/17.
//  Copyright © 2017 Seth. All rights reserved.
//

import Foundation

public enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
    case parseError
}
