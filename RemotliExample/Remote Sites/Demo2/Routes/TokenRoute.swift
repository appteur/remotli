//
//  Token.swift
//  RemotliExample
//
//  Created by Seth on 6/4/18.
//  Copyright © 2018 aii. All rights reserved.
//

import Foundation
import Remotli

// This is a sample route that makes use of an enum to generate differing parameter
// options sent to the same token endpoint depending on the type of token desired.
enum TokenRoute: Routable {
    
    // each case in this route represents a different token type that can
    // be requested from this api route or endpoint. All cases share the same
    // method, uri, mimeType and headers but send different parameters to the
    // remote host.
    case anonymous
    case federated
    case refresh(token: String)
    case credential
    case social
    
    var method: HTTPMethod {
        return .get
    }
    
    var uri: String {
        return "/api/demo2/token.json"
    }
    
    var mimeType: MimeType {
        return .applicationJson
    }
    
    var port: Int? {
        return nil
    }
    
    var headers: [String: String]? {
        return [
            :
        ]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .anonymous: return ["credentialType": "ANONYMOUS"]
        case .federated: return ["federatedProvider": "CF_AUTH", "credentialType": "FEDERATED", "credential": "aa", "name": "aa@xx.com"]
        case .refresh(let token): return ["credentialType": "REFRESH_TOKEN", "credential": token]
        case .credential: return ["credentialType": "CREDENTIAL"]
        case .social: return ["credentialType": "SOCIAL_TOKEN"]
        }
    }
    
    var requiresAuth: Bool {
        return false
    }
    
    var cachePolicy: URLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}

