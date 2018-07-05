//
//  ResponsePlugin.swift
//  Remotli
//
//  Created by Seth on 5/25/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public protocol ResponsePlugin {
    
    var identifier: String { get }
    
    @discardableResult
    func didReceive<T: Codable>(_ response: URLResponse?, data: Data?, error: Error?, forRequest request: URLRequest, completion: @escaping (T?, Error?) -> Void) -> Bool
}
