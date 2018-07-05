//
//  ResponseErrorPlugin.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public class ResponseErrorPlugin: ResponsePlugin, JSONParsable {
    
    public var identifier = ResponsePluginIdentifier.error.description
    var decoder = JSONDecoder()
    
    public init() {
        // Here for compliance with convention
    }

    public func didReceive<T: Codable>(_ response: URLResponse?, data: Data?, error: Error?, forRequest request: URLRequest, completion: @escaping (T?, Error?) -> Void) -> Bool {
        
        guard let httpResponse = response as? HTTPURLResponse, let responseError = ResponseError.init(code: httpResponse.statusCode) else  {
            
            // the response status code isn't an error so pass
            return false
        }
        
        guard let data = data else {
            // we have an error parsed from the response status code
            // but no data, so just pass the responseError back
            completion(nil, responseError)
            
            // response is handled so return true
            return true
        }
        
        do {

            let apiError = AggregateAPIError(responseError: responseError)
            
            // serialize data if possible
            apiError.response = try parseData(from: data)
            
            // complete with the parsed object, no error
            completion(nil, apiError)
            
            // response handled so return true
            return true
            
        } catch {
            
            // unable to parse the response data so complete with the generic response error
            completion(nil, responseError)
            
            // response is handled so return true
            return true
        }
    }
}
