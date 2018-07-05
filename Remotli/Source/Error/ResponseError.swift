//
//  ResponseError.swift
//  Remotli
//
//  Created by Seth on 4/6/17.
//  Copyright © 2017 Seth. All rights reserved.
//

import Foundation

/// Specifies the possible errors that a request to an api could return.
///
/// - apiError: Specifies api errors that are returned as part of the response from the api.
/// - badRequest: Specifies errors where the api is unable to process the request due to errors with the request data.
/// - unauthorized: Specifies errors where the requestor failed to provide adequate credentials for the data being requested.
/// - paymentRequired: Specifies errors where a payment is required before the request can be fulfilled.
/// - forbidden: Spefies errors where the requestor does not have proper access rights for the data being requested.
/// - notFound: Spefies errors where the resource being requested does not exist.
/// - methodNotAllowed: Specifies errors where the endpoint being called either does not exist or is not allowed for the requestor.
/// - requestEntityTooLarge: Specifies errors where the request being sent is too large to be processed.
/// - responseParseError: Specifies errors where the response being received is not able to be parsed by the network/api processor.
/// - unknownError: Specifies all other errors that have not been defined.
public enum ResponseError: Error, Equatable, CustomStringConvertible {
    
    // custom response error
    case custom(message: String, errorName: String?, code: Int?)
    
    // 3xx codes (Redirection)
    case multipleChoices
    case movedPermanently
    case found
    case seeOther
    case notModified
    case useProxy
    case switchProxy
    case temporaryRedirect
    case permanentRedirect
    
    // 4xx codes (client error)
    case badRequest
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case methodNotAllowed
    case notAcceptable
    case proxyAuthRequired
    case requestTimeout
    case conflict
    case gone
    case lengthRequired
    case preconditionFailed
    case payloadTooLarge
    case uriTooLong
    case unsupportedMediaType
    case rangeNotSatisfiable
    case expectationFailed
    case imATeapot
    case misdirectedRequest
    case unprocessableEntity
    case locked
    case failedDependency
    case upgradeRequired
    case preconditionRequired
    case tooManyRequests
    case requestHeadersTooLarge
    case legallyUnavailable
    
    // 5xx codes (server errors)
    case internalServerError
    case notImplemented
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case httpVersionUnsupported
    case variantAlsoNegotiates
    case insufficientStorage
    case loopDetected
    case notExtended
    case networkAuthRequired
    
    case unknownError
    
    public var description: String {
        switch self {
        
        case .custom(let message, _, _):    return message
            
        case .multipleChoices: return "Multiple choices are available."
        case .movedPermanently: return "Moved permanently."
        case .found:            return "Moved temporarily."
        case .seeOther:         return "Resource has been relocated"
        case .notModified:      return "Resouce has not changed since last fetch."
        case .useProxy:         return "Resource is only available through a proxy."
        case .switchProxy:      return "Subsequent requests should use specified proxy."
        case .temporaryRedirect: return "Temporary redirect."
        case .permanentRedirect: return "Permanent redirect."
            
        case .badRequest:           return "Bad Request"
        case .unauthorized:         return "Unauthorized"
        case .paymentRequired:      return "Payment Required"
        case .forbidden:            return "Forbidden"
        case .notFound:             return "Not Found"
        case .methodNotAllowed:     return "Method Not Allowed"
        
        default:
            return "An unknown error occured. Please try again later."
        }
    }
    
    public var code: Int {
        switch self {
            
        // 3xx codes
        case .multipleChoices:          return 300
        case .movedPermanently:         return 301
        case .found:                    return 302
        case .seeOther:                 return 303
        case .notModified:              return 304
        case .useProxy:                 return 305
        case .switchProxy:              return 306
        case .temporaryRedirect:        return 307
        case .permanentRedirect:        return 308
            
        // 4xx codes
        case .badRequest:               return 400
        case .unauthorized:             return 401
        case .paymentRequired:          return 402
        case .forbidden:                return 403
        case .notFound:                 return 404
        case .methodNotAllowed:         return 405
        case .notAcceptable:            return 406
        case .proxyAuthRequired:        return 407
        case .requestTimeout:           return 408
        case .conflict:                 return 409
        case .gone:                     return 410
        case .lengthRequired:           return 411
        case .preconditionFailed:       return 412
        case .payloadTooLarge:          return 413
        case .uriTooLong:               return 414
        case .unsupportedMediaType:     return 415
        case .rangeNotSatisfiable:      return 416
        case .expectationFailed:        return 417
        case .imATeapot:                return 418
        case .misdirectedRequest:       return 421
        case .unprocessableEntity:      return 422
        case .locked:                   return 423
        case .failedDependency:         return 424
        case .upgradeRequired:          return 426
        case .preconditionRequired:     return 428
        case .tooManyRequests:          return 429
        case .requestHeadersTooLarge:   return 431
        case .legallyUnavailable:       return 451
            
        // 5xx codes
        case .internalServerError:      return 500
        case .notImplemented:           return 501
        case .badGateway:               return 502
        case .serviceUnavailable:       return 503
        case .gatewayTimeout:           return 504
        case .httpVersionUnsupported:   return 505
        case .variantAlsoNegotiates:    return 506
        case .insufficientStorage:      return 507
        case .loopDetected:             return 508
        case .notExtended:              return 510
        case .networkAuthRequired:      return 511
            
        case .custom(_, _, let code): return (code != nil) ? code! : 0
        default:
            return 999 // default code for now...
        }
    }
}

extension ResponseError {
    
    public init?(code: Int) {
        switch code {
        case 300: self = .multipleChoices
        case 301: self = .movedPermanently
        case 302: self = .found
        case 303: self = .seeOther
        case 304: self = .notModified
        case 305: self = .useProxy
        case 306: self = .switchProxy
        case 307: self = .temporaryRedirect
        case 308: self = .permanentRedirect
            
        case 400: self = .badRequest
        case 401: self = .unauthorized
        case 402: self = .paymentRequired
        case 403: self = .forbidden
        case 404: self = .notFound
        case 405: self = .methodNotAllowed
        case 406: self = .notAcceptable
        case 407: self = .proxyAuthRequired
        case 408: self = .requestTimeout
        case 409: self = .conflict
        case 410: self = .gone
        case 411: self = .lengthRequired
        case 412: self = .preconditionFailed
        case 413: self = .payloadTooLarge
        case 414: self = .uriTooLong
        case 415: self = .unsupportedMediaType
        case 416: self = .rangeNotSatisfiable
        case 417: self = .expectationFailed
        case 418: self = .imATeapot
        case 421: self = .misdirectedRequest
        case 422: self = .unprocessableEntity
        case 423: self = .locked
        case 424: self = .failedDependency
        case 426: self = .upgradeRequired
        case 428: self = .preconditionRequired
        case 429: self = .tooManyRequests
        case 431: self = .requestHeadersTooLarge
        case 451: self = .legallyUnavailable
            
        case 500: self = .internalServerError
        case 501: self = .notImplemented
        case 502: self = .badGateway
        case 503: self = .serviceUnavailable
        case 504: self = .gatewayTimeout
        case 505: self = .httpVersionUnsupported
        case 506: self = .variantAlsoNegotiates
        case 507: self = .insufficientStorage
        case 508: self = .loopDetected
        case 510: self = .notExtended
        case 511: self = .networkAuthRequired
        default:
            return nil
        }
    }
}

public func ==(lhs: ResponseError, rhs: ResponseError) -> Bool {
    switch (lhs, rhs) {
    case (.custom, .custom):
        return true
    default:
        return false
    }
    
}
