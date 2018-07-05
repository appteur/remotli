//
//  RequestPlugin.swift
//  Remotli
//
//  Created by Seth on 5/25/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public protocol RequestPlugin {
    
    var identifier: String { get }
    
    func configure(_ request: inout URLRequest, for routable: Routable)
}
