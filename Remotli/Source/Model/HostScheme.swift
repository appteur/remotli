//
//  HostScheme.swift
//  Remotli
//
//  Created by Seth on 5/25/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public enum HostScheme {
    case http
    case https
    case ftp
    
    var value: String {
        switch self {
        case .http: return "http://"
        case .https: return "https://"
        case .ftp: return "ftp://"
        }
    }
}
