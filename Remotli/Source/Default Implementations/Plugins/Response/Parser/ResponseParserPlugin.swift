//
//  ResponseParserPlugin.swift
//  Remotli
//
//  Created by Seth on 6/1/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class JSONResponseParserPlugin: ResponsePlugin, JSONParsable {
    
    public var identifier = ResponsePluginIdentifier.jsonParser.description
    var decoder = JSONDecoder()
    
    public init() {
        // here for conformance with convention
    }

    public func didReceive<T: Codable>(_ response: URLResponse?, data: Data?, error: Error?, forRequest request: URLRequest, completion: @escaping (T?, Error?) -> Void) -> Bool {
        
        // verify we have data and no error
        guard let data = data, error == nil else {
            
            // call the completion with error response
            completion(nil, NetworkError.responseError)
            
            // response is handled with error, return true
            return true
        }
        
        do {
            // serialize data if possible
            let parsed: T = try parseData(from: data)
            
            // complete with the parsed object, no error
            completion(parsed, nil)
            
            // response handled so return true
            return true
            
        } catch {
            
            // complete with a parser error
            completion(nil, SerializationError.parseError)
            
            // response is handled so return true
            return true
        }
    }
}
