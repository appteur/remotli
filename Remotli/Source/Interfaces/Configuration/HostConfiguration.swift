//
//  HostConfiguration.swift
//  Remotli
//
//  Created by Seth on 5/25/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public protocol HostConfiguration {
    var scheme: HostScheme { get set }
    var host: String { get set }
}

extension HostConfiguration {
    
    func basePath() -> String {
        return scheme.value+host
    }
    
    func baseURLComponents() -> URLComponents? {
        return URLComponents.init(string: basePath())
    }
    
    func baseURL() -> URL? {
        return baseURLComponents()?.url
    }
}
