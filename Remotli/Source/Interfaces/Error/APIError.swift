//
//  APIError.swift
//  Remotli
//
//  Created by Seth on 6/2/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation

public protocol ApiError: Error {
    associatedtype ApiErrorModel: Codable

    // links to a response error based on the api response status code
    var responseError: ResponseError? { get set }
    
    // links to the actual error response returned by the api
    var response: ApiErrorModel? { get set }
}
