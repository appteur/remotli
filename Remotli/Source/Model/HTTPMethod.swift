//
//  HTTPMethods.swift
//  Networking
//
//  Created by Seth on 4/7/17.
//  Copyright © 2017 Seth. All rights reserved.
//

import Foundation


/// Provides http methods as an enum for easier use throughout the networking library.
public enum HTTPMethod: String {
    case head
    case get
    case post
    case put
    case delete
    case options
    case connect
    case trace
    case patch
    
    var description: String {
        return self.rawValue.uppercased()
    }
}
