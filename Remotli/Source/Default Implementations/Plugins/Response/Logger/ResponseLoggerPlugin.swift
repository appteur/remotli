//
//  ResponseLoggerPlugin.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class ResponseLoggerPlugin: ResponsePlugin {
    
    public var identifier = ResponsePluginIdentifier.logger.description
    
    public init() {
        // here for conformance with convention
    }

    public func didReceive<T: Codable>(_ response: URLResponse?, data: Data?, error: Error?, forRequest request: URLRequest, completion: @escaping (T?, Error?) -> Void) -> Bool {
        
        print("\n")
        print("----- Remotli Response -----")
        print("\tURL: \(String(describing: request.url?.absoluteString))")
        if let httpResponse = response as? HTTPURLResponse {
            print("\tResponse Code: \(httpResponse.statusCode)")
        }
        if let data = data {
            let dataStr = String.init(data: data, encoding: String.Encoding.utf8)
            print("\tResponse Data: \n\(String(describing: dataStr))\n")
        }
        if let error = error {
            print("\tResponse Error: \(error)")
        }
        print("----- ***** -----")
        print("\n")
        
        // this plugin simply logs the response, it does not handle it so return false
        return false
    }
}
