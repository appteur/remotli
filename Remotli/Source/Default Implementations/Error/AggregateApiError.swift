//
//  AggregateApiError.swift
//  Remotli
//
//  Created by Seth on 6/3/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

// Default class that aggregates the api error based on status code and
// the json response as a model object returned from the api
public class AggregateAPIError: ApiError {
    
    public var responseError: ResponseError?
    public var response: ErrorResponse?
    
    public init(responseError: ResponseError?) {
        self.responseError = responseError
    }
}
